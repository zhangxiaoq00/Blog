package com.zyc.controller;

import com.zyc.model.*;
import com.zyc.model.JuziExample.Criteria;
import com.zyc.redis.JedisTemplateUtil;
import com.zyc.service.*;
import com.zyc.spider.JuziService;
import com.zyc.spider.NewsSpider;
import com.zyc.spider.TodayInHistorySpider;
import com.zyc.util.DownloadRecord;
import com.zyc.util.ExcleUtil;
import jxl.write.WriteException;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.http.client.ClientProtocolException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller("houtaiController")
@RequestMapping("/Houtai")
@RequiresRoles(value="admin")
public class HoutaiController {
	@ExceptionHandler(value = Exception.class)
	public ModelAndView errmsg(ModelAndView modelAndView,Exception exception) {
		modelAndView.setViewName("/Houtai/error/web/error.jsp");
		modelAndView.addObject("msg",exception.getStackTrace());
		return modelAndView;
	}

	@Autowired
	@Qualifier("iPServiceImplements")
	private IPService iPservice;
	
	@Autowired
	@Qualifier("juZiSpider")

	private JuziService juziservice;
	
	@Autowired
	@Qualifier("juZITypeServiceImplements")
	private JuZiTypeService juZiTypeService;

	@Autowired
	@Qualifier("wenzhangServiceImplements")
	private WenzhangService wenzhangService;

	@Autowired
	@Qualifier("iPServiceImplements")
	private IPService iPService;

	@Autowired
    private JedisTemplateUtil jedisTemplateUtil;;

    @Autowired
    private TodayInHistorySpider todayInHistorySpider;

    @Autowired
	private NewsSpider newsSpider;
	/**
	 * 文件树状图
	 * @param response
	 * @param request
	 * @throws IOException
	 */
	@RequestMapping("/filelist.do")
	public void filelist(HttpServletResponse response, HttpServletRequest request) throws IOException {
		PrintWriter out = new PrintWriter(response.getOutputStream());
		String dir = request.getParameter("dir");
		if (dir == null) {
			return;
		}

		if (dir.charAt(dir.length() - 1) == '\\') {
			dir = dir.substring(0, dir.length() - 1) + "/";
		} else if (dir.charAt(dir.length() - 1) != '/') {
			dir += "/";
		}

		dir = java.net.URLDecoder.decode(dir, "UTF-8");

		if (new File(dir).exists()) {
			String[] files = new File(dir).list(new FilenameFilter() {
				public boolean accept(File dir, String name) {
					return name.charAt(0) != '.';
				}
			});
			Arrays.sort(files, String.CASE_INSENSITIVE_ORDER);
			out.print("<ul class=\"jqueryFileTree\" style=\"display: none;\">");
			// All dirs
			for (String file : files) {
				if (new File(dir, file).isDirectory()) {
					out.print(
							"<li class=\"directory collapsed\"><a rel=\""
									+ dir + file + "/\">" + file + "</a></li>");
				}
			}
			// All files
			for (String file : files) {
				if (!new File(dir, file).isDirectory()) {
					int dotIndex = file.lastIndexOf('.');
					String ext = dotIndex > 0 ? file.substring(dotIndex + 1) : "";
					out.print("<li class=\"file ext_" + ext + "\"><a rel=\"" + dir + file + "\">" + file + "</a><a href='/Houtai/download1"+dir+file+".do?filepath="+dir+file+"&filename="+file.toString()+"'>下载</a><a href='/Houtai/delete1"+dir+file+".do?filepath="+dir+file+"'>删除</a></li>");
				}
			}
			out.print("</ul>");
			out.flush();
			out.close();
		}
	}
	/**
	 * 删除文件
	 */
	@RequestMapping(value="/delete/home/imgs/**/{pathbiaoti}/{path}.*")
	public ModelAndView download(@PathVariable("pathbiaoti")String pathbiaoti,@PathVariable("path") String path,HttpServletRequest request,HttpServletResponse response,ModelAndView modelAndView) throws IOException{
	    File file2 = new File("/home/imgs/file/"+pathbiaoti+"/"+path);
	    file2.delete();
	    modelAndView.setViewName("/Houtai/file");
	    return modelAndView;
	}
	/**
	 * 删除文件
	 */
	@RequestMapping(value="/delete1/**/*.do")
	public ModelAndView download1(HttpServletRequest request,HttpServletResponse response,ModelAndView modelAndView) throws IOException{
		String path = request.getParameter("filepath");
	    File file2 = new File(path);
	    file2.delete();
	    modelAndView.setViewName("/Houtai/file");
	    return modelAndView;
	}
	/**
	 * ip条件查询
	 * @param modelAndView
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value="/iplist.do")
	public ModelAndView listIP(ModelAndView modelAndView,HttpServletRequest request) throws ParseException{
		IpExample ipExample = new IpExample();
		Integer currentPage = null;
		Integer size = null;
		String mindate=request.getParameter("mindate");
		String mintime=request.getParameter("mintime");
		String maxdate1=request.getParameter("maxdate1");
		String maxtime1 =request.getParameter("maxtime1");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date fmindate = null;
		Date fmaxdate = null;
		IpExample.Criteria criteria = ipExample.createCriteria();
		if(mindate!=null&&!"".equals(mindate)){
			if(mintime==null&&!"".equals(mintime)){
				mintime= "00:00";
				fmindate = dateFormat.parse(mindate+" "+mintime);
			}else{
				fmindate = dateFormat.parse(mindate+" "+mintime);
				criteria.andDateGreaterThan(fmindate);
			}
		}
		if(maxdate1!=null&&!"".equals(maxdate1)){
			if(maxtime1==null&&!"".equals(maxtime1)){
				maxdate1="23:59";
				fmaxdate = dateFormat.parse(maxdate1+" "+maxtime1);
			}else{
				fmaxdate = dateFormat.parse(maxdate1+" "+maxtime1);
			}
			criteria.andDateLessThan(fmaxdate);
		}
		if(request.getParameter(("currentpage"))!=null){
			currentPage = Integer.parseInt(request.getParameter("currentpage"));
		}
		if(request.getParameter(("size"))!=null){
			size = Integer.parseInt(request.getParameter("size"));
		}
		Page2<Ip, IpExample> page2 = new Page2<Ip, IpExample>(ipExample, currentPage, size);
		page2 = iPservice.findIpByPage(page2);
		modelAndView.addObject("page2",page2);
		modelAndView.setViewName("/Houtai/listip");
		if(mindate!=null){
			modelAndView.addObject("mindate",mindate);
		}
		if(mintime!=null){
			modelAndView.addObject("mintime",mintime);
		}
		if(maxdate1!=null){
			modelAndView.addObject("maxdate1",maxdate1);
		}
		if(maxtime1!=null){
			modelAndView.addObject("maxtime1",maxtime1);
		}
		return modelAndView;
	}
	/**
	 * 爬取句子
	 * @param modelAndView
	 * @param request
	 * @return
	 */
	@RequestMapping("/updataJuzi.do")
	public ModelAndView updatajuzi(ModelAndView modelAndView,HttpServletRequest request){
		Integer currentPage = null;
		Integer size = null;
		JuziExample juziExample = new JuziExample();
		String url = request.getParameter("juziurl");
		juziservice.updateJuzi(url);
		if(request.getParameter(("currentpage"))!=null){
			currentPage = Integer.parseInt(request.getParameter("currentpage"));
		}
		if(request.getParameter(("size"))!=null){
			size = Integer.parseInt(request.getParameter("size"));
		}
		Page2<Juzi, JuziExample> page2 = new Page2<Juzi, JuziExample>(juziExample, currentPage, size);
		page2=juziservice.findJuziByPage(page2);
		modelAndView.addObject(page2);
		modelAndView.setViewName("/Houtai/juzi");
		return modelAndView;
	}
	/**
	 * 查看句库
	 * @param modelAndView
	 * @param request
	 * @return
	 */
	@RequestMapping("/listjuzi.do")
	public ModelAndView listjuzi(ModelAndView modelAndView,HttpServletRequest request){
		Integer currentPage = null;
		Integer size = null;
		String juzi = request.getParameter("juzi");
		String juziType = request.getParameter("juzileixing");
		String chuchu = request.getParameter("chuchu");
		if(request.getParameter("currentpage")!=null&&!"".equals(request.getParameter("currentpage").trim())){
			currentPage = Integer.parseInt(request.getParameter("currentpage"));
		}
		if(request.getParameter("size")!=null&&!"".equals(request.getParameter("size").trim())){
			size = Integer.parseInt(request.getParameter("size"));
		}
		JuziExample juziExample = new JuziExample();
		Criteria criteria = juziExample.createCriteria();
		if(juzi!=null&&!"".equals(juzi)){
			criteria=criteria.andJuzineirongLike("%"+juzi+"%");
			currentPage=0;
		}
		if(juziType!=null&&!"".equals(juziType)){
			Integer temp = Integer.parseInt(juziType);
			criteria=criteria.andJuzileixingEqualTo(temp);
			currentPage=0;
		}
		if(chuchu!=null&&!"".equals(chuchu)){
			criteria=criteria.andJuzichuchuLike("%"+chuchu+"%");
			currentPage=0;
		}
		juziExample.getOredCriteria().add(criteria);
		Page2<Juzi, JuziExample> page2 = new Page2<Juzi, JuziExample>(juziExample, currentPage, size);
		page2=juziservice.findJuziByPage(page2);
		modelAndView.addObject("page2",page2);
		modelAndView.addObject("juzileixing",juZiTypeService.finAll());
		modelAndView.addObject("juzitype",juziType);
		modelAndView.addObject("chuchu",chuchu);
		modelAndView.addObject("juzi",juzi);
		modelAndView.setViewName("/Houtai/juzi");
		return modelAndView;
	}
	@RequestMapping("/getOS.do")
	public void getOS(HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		GetOSInfo getOSInfo = new GetOSInfoImplement();
		out.print(getOSInfo.getJVM());
		out.flush();
		out.close();
	}


	@RequestMapping(value="/exportExcle.do")
	public void exportExcle(HttpServletRequest request, HttpServletResponse response, String juzi, String juzileixing, String chuchu) {
	    //todo  行数过长
        File file2 = new File("/home/imgs/file/temp/"+new Date().getTime()+".xls");
        ExcleUtil excleUtil = new ExcleUtil();
        JuziExample juziExample = new JuziExample();
        Criteria criteria = juziExample.createCriteria();
        if(juzi!=null&&!"".equals(juzi)){
            criteria.andJuzineirongLike("%"+juzi+"%");
        }
        if(juzileixing!=null&&!"".equals(juzileixing)){
            Integer temp = Integer.parseInt(juzileixing);
            criteria.andJuzileixingEqualTo(temp);
        }
        if(chuchu!=null&&!"".equals(chuchu)){
            criteria.andJuzichuchuLike("%"+chuchu+"%");
        }
        List<Juzi> juzis = juziservice.findall(juziExample);
        Object[][] result = new Object[juzis.size()][3];

        for (int i = 0; i <juzis.size() ; i++) {
            result[i][0] = juzis.get(i).getJuzineirong();
            result[i][1] = juzis.get(i).getJuzichuchu();
            result[i][2] = juzis.get(i).getJuziTypeKey().getLeixingming();
        }
        //判断当前是否有解结果
        PrintWriter out = null;
        if(result==null||result.length==0){
            try {
                out = response.getWriter();
                out.print("failed:-0001");
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }
        try {
            out = response.getWriter();
            excleUtil.writetoExcle(file2.getAbsolutePath(),juzis.get(0).getJuziTypeKey().getLeixingming(),result,true,"句子内容","句子出处","句子类型");
            out.print("success__"+file2.getName()+"__"+juzis.get(0).getJuziTypeKey().getLeixingming());
        } catch (IOException e) {
            e.printStackTrace();
            out.print("failed");
        } catch (WriteException e) {
            e.printStackTrace();
            out.print("failed");
        }
        finally {
            if(out!=null) {
                out.close();
            }
        }
    }
    @RequestMapping("/downloadExportExcle.do")
    public void downloadExportExcle(HttpServletRequest request, HttpServletResponse response,String filename,String dname) throws IOException {
	    File file2 = new File("/home/imgs/file/temp/"+filename);
        OutputStream outputStream = response.getOutputStream();
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=dict.txt");
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition","attachment;filename="+new String(dname.getBytes("gb2312"), "ISO8859-1" )+".xls");
        response.setContentLength(Integer.parseInt(String.valueOf(file2.length())));
        outputStream.write(FileUtils.readFileToByteArray(file2));

        outputStream.flush();
        outputStream.close();
        file2.delete();
    }
	/**
	 * 获取每日新闻
	 * @param request
	 */
	@RequestMapping(value="/getNews/{type}.*")
	public void getnewsByType(HttpServletRequest request,HttpServletResponse response,@PathVariable("type") String type) throws IOException {
		PrintWriter out = response.getWriter();
		List<String> result = newsSpider.getNews(NewsType.valueOf(type));
		for(String temp : result){
			out.print(temp);
		}
		out.flush();
		out.close();
	}

	/**
	 * 下载保存在服务器端虚拟路径的文件
	 */
	@RequestMapping(value = "/download1/**/**.do")
	public void download(HttpServletRequest request, @RequestParam("filename") String filename,HttpServletResponse response)
			throws IOException {
		String path = request.getParameter("filepath");
		File file2 = new File(path);
        //声明本次下载状态的记录对象
        DownloadRecord downloadRecord = new DownloadRecord(filename, path, request);
        //设置响应头和客户端保存文件名
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + file2.getName());
        response.setHeader("Content-Length", String.valueOf(file2.length()));
        //用于记录以完成的下载的数据量，单位是byte
        long downloadedLength = 0l;
        try {
            //打开本地文件流
            InputStream inputStream = new FileInputStream(path);
            //激活下载操作
            OutputStream os = response.getOutputStream();

            //循环写入输出流
            byte[] b = new byte[2048];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
                downloadedLength += b.length;
            }
            // 这里主要关闭。
            os.close();
            inputStream.close();
        } catch (Exception e){
            downloadRecord.setStatus(DownloadRecord.STATUS_ERROR);
            //throw e;
        }
        downloadRecord.setStatus(DownloadRecord.STATUS_SUCCESS);
        downloadRecord.setEndTime(new Timestamp(System.currentTimeMillis()));
        downloadRecord.setLength(downloadedLength);
        //存储记录
	}




	/**
	 * 富文本编辑器上传图片
	 *
	 * @param file
	 * @param request
	 * @param response
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value = "/upLoadImg")
	public void upload(@RequestParam(value = "wangEditorH5File", required = false) MultipartFile file,
					   HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException {
		// 创建一个通用的多部分解析器
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			ServletOutputStream output = response.getOutputStream();
			while (iter.hasNext()) {
				// 取得上传文件
				MultipartFile file1 = multiRequest.getFile(iter.next());
				if (file1 != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file1.getOriginalFilename();
					// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
					if (myFileName.trim() != "") {
						// 重命名上传后的文件名
						String fileName = "/" + UUID.randomUUID().toString().replace("-", "") + "."
								+ file1.getOriginalFilename().split("\\.")[1];
						// 定义上传路径
						// String path =
						// request.getServletContext().getRealPath("imgs")+fileName;
						String hash = Calendar.getInstance().get(Calendar.YEAR) + "_"
								+ (Calendar.getInstance().get(Calendar.MONTH) + 1) + "_"
								+ Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
						String path = "/home/imgs/" + hash;
						File pathf = new File(path);
						if (!pathf.exists()) {
							pathf.mkdirs();
						}
						path = "/home/imgs/" + hash + fileName;
						File localFile = new File(path);
						file1.transferTo(localFile);
						// output.print(request.getServletContext().getContextPath()+"/imgs/"+fileName);
						output.print(path);
					}
				}
			}

		}
	}


	/**
	 * 后台主页
	 *
	 * @param request
	 * @return
	 * @throws ClientProtocolException
	 * @throws org.apache.http.ParseException
	 * @throws IOException
	 */
	@RequestMapping(value = "/index.do")
	public ModelAndView index(HttpServletRequest request)
			throws ClientProtocolException, org.apache.http.ParseException, IOException {
		request.getSession().getAttribute("user");
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		Integer ipResultCount = 10;// IP查询的数量
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("count", wenzhangService.countWenzhang(user));
		modelAndView.addObject("countIp", iPService.countIP(new IpExample()));
		JSONObject listip_date = new JSONObject();
		List<Ip_Date> list = iPService.selectCountByDay(ipResultCount--);
		for (int i = 0; i < ipResultCount / 2 + 1; i++) {
			Ip_Date temp = null;
			temp = list.get(i);
			list.set(i, list.get(ipResultCount - i));
			list.set(ipResultCount - i, temp);
		}
		listip_date.put("list", list);
		modelAndView.addObject("listip_date", listip_date);
		JSONObject typeCount = new JSONObject();
		typeCount.put("typecount", juZiTypeService.getGruop());
		/*//获取每日新闻
		modelAndView.addObject("allNews", new NewsSpider().getNews(NewsType.ALLNEWS));*/
		//获取历史上的今天
		modelAndView.addObject("todayInHistory",todayInHistorySpider.getTodayInHistorySpider());
		//获取文章类型计数
		modelAndView.addObject("typecount", typeCount);
		//获取句库计数
		modelAndView.addObject("juziCount", juziservice.countJuZiByExample(new JuziExample()));
		//获取当前服务器时间
		modelAndView.addObject("nowDate", jedisTemplateUtil.get("date".getBytes(),0));
		modelAndView.setViewName("/Houtai/index1");
		return modelAndView;
	}

	/**
	 * 进入修改博客主页的修改页面
	 *
	 * @param request
	 * @param modelAndView
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/modifyJuzi.do")
	public ModelAndView modifyJuzi(HttpServletRequest request, ModelAndView modelAndView) throws IOException {
		File file = new File("/home/imgs/conf/index.properties");
		Properties properties = new Properties();
		properties.load(new InputStreamReader(new FileInputStream(file), "utf-8"));
		Map<String, String> juzis = new HashMap<String, String>();
		for (Object key : properties.keySet()) {
			juzis.put((String) key, new String(properties.get(key).toString().getBytes(), "utf-8"));
		}
		modelAndView.setViewName("/Houtai/modifyJuzi");
		modelAndView.addObject("juzis", juzis);
		return modelAndView;
	}

	/**
	 * 修改主页图片
	 *
	 * @param request
	 * @param modelAndView
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/modifyJuziImg.do")
	public ModelAndView modifyJuziImg(HttpServletRequest request, ModelAndView modelAndView) throws IOException {
		File file = new File("/home/imgs/conf/index.properties");
		Properties properties = new Properties();
		properties.load(new InputStreamReader(new FileInputStream(file), "utf-8"));
		Map<String, String> juzis = new HashMap<String, String>();
		for (Object key : properties.keySet()) {
			juzis.put((String) key, new String(properties.get(key).toString().getBytes(), "utf-8"));
		}
		modelAndView.setViewName("/Houtai/modifyJuzImg");
		modelAndView.addObject("juzis", juzis);
		return modelAndView;
	}

	/**
	 * 修改主页配置文件的动作
	 *
	 * @param request
	 * @param modelAndView
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/modifyJuziaction.do")
	public ModelAndView modifyJuziActioin(HttpServletRequest request, ModelAndView modelAndView) throws IOException {
		File file = new File("/home/imgs/conf/index.properties");
		Map<String, String> juzis = new HashMap<String, String>();
		Enumeration<String> names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String name = names.nextElement();
			if (name.contains("juzi")) {
				String count = name.substring(7);
				juzis.put("img_bg_" + count, new String(request.getParameter(name).toString().getBytes(), "utf-8"));
			}
		}
		Properties properties = new Properties();
		properties.load(new FileInputStream(file));
		for (Map.Entry<String, String> temp : juzis.entrySet()) {
			properties.setProperty(temp.getKey(), temp.getValue());
		}
		PrintWriter printWriter = new PrintWriter(file, "utf-8");
		properties.store(printWriter, "by ZYC 首页句子以及图片的记录");
		printWriter.close();
		modelAndView.setViewName("redirect:/Houtai/index.do");
		return modelAndView;
	}

	/**
	 * 上传附件
	 *
	 * @param request
	 * @param response
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value = "/addFile.do")
	public void addfile(HttpServletRequest request, HttpServletResponse response)
			throws IllegalStateException, IOException {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			PrintWriter output = response.getWriter();
			while (iter.hasNext()) {
				// 取得上传文件
				MultipartFile file1 = multiRequest.getFile(iter.next());
				if (file1 != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file1.getOriginalFilename();
					// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
					if (myFileName.trim() != "") {
						// 重命名上传后的文件名
						String fileName = "/" + UUID.randomUUID().toString().replace("-", "") + "."
								+ file1.getOriginalFilename().split("\\.")[1];
						// 定义上传路径
						// String path =
						// request.getServletContext().getRealPath("imgs")+fileName;
						String hash = Calendar.getInstance().get(Calendar.YEAR) + "_"
								+ (Calendar.getInstance().get(Calendar.MONTH) + 1) + "_"
								+ Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
						String path = "/home/imgs/file/" + hash;
						File pathf = new File(path);
						if (!pathf.exists()) {
							pathf.mkdirs();
						}
						path = "/home/imgs/file/" + hash + "/" + myFileName;
						File localFile = new File(path);
						System.out.println(localFile.getAbsolutePath());
						file1.transferTo(localFile);
						// output.print(request.getServletContext().getContextPath()+"/imgs/"+fileName);
						output.print("<a href=/download" + path + ".do?filename=" + myFileName + ">"
								+ myFileName + "</a>");
					}
				}
			}
		}
	}

	/**
	 * 修改主页图片
	 *
	 * @param request
	 * @param response
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value = "/modifyJuziImgAction.do")
	public void modifyJuziImg(HttpServletRequest request, HttpServletResponse response)
			throws IllegalStateException, IOException {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			ServletOutputStream output = response.getOutputStream();
			while (iter.hasNext()) {
				// 取得上传文件
				MultipartFile file1 = multiRequest.getFile(iter.next());
				if (file1 != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file1.getOriginalFilename();
					// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
					if (myFileName.trim() != "") {
						String path = "/home/imgs/img_bg_" + request.getParameter("id") + ".jpg";
						File pathf = new File(path);
						if (!pathf.exists()) {
							pathf.mkdirs();
						}
						File localFile = new File(path);
						System.out.println(localFile.getAbsolutePath());
						file1.transferTo(localFile);
						output.print("<a href=/Houtai/download" + path + ".do?filename=" + myFileName + ">"
								+ myFileName + "</a>");
					}
				}
			}
		}
	}


    /**
     * 删除文章
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete")
    public ModelAndView deleteWenZhang(HttpServletRequest request) {
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Integer id = Integer.parseInt(request.getParameter("wenzhangid"));
        wenzhangService.deleteWenzhang(id,user);
        return new ModelAndView("redirect:/Houtai/findByPage.do");
    }

    /**
     * 修改文章
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/modifywenzhangaction")
    public ModelAndView modifyWenZhang(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
    	User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Wenzhang wenZhang = new Wenzhang();
        wenZhang.setWenzhangneirong(request.getParameter("wenzhangneirong"));
        wenZhang.setWenzhangbiaoti(request.getParameter("wenzhangbiaoti"));
        wenZhang.setWenzhangleixing(request.getParameter("wenzhangleixing"));
        wenZhang.setWenzhangid(Integer.parseInt(request.getParameter("wenzhangid1")));
        wenZhang.setWenzhangchunwenben(request.getParameter("wenzhangchunwenben").trim());
        wenzhangService.modifyWenzhang(wenZhang,user);
        return new ModelAndView("redirect:/Houtai/findByPage.do");
    }

    /**
     * 进入文章修改界面
     *
     * @param request
     * @param printWriter
     */
    @RequestMapping("/modifywenzhang")
    public void findWenZhangByid(HttpServletRequest request, PrintWriter printWriter) {
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        Wenzhang wenZhang = wenzhangService.findWenzhangByid(Integer.parseInt(request.getParameter("wenzhangid")),user);
        JSONObject json = new JSONObject();
        json.put("wenzhang", wenZhang);
        printWriter.print(json.toString());
        printWriter.flush();
        printWriter.close();
    }

    /**
     * 文章分页查找
     *
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws ClientProtocolException
     * @throws net.sf.json.JSONException
     */
    @RequestMapping("/findByPage.**")
    public ModelAndView finWenZhangByPage(HttpServletRequest request, HttpServletResponse response) throws net.sf.json.JSONException, ClientProtocolException, IOException {
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        ModelAndView modelAndView = new ModelAndView();
        WenzhangExample wenzhangExample = new WenzhangExample();
        WenzhangExample.Criteria criteria =wenzhangExample.createCriteria();
        if(request.getParameter("wenzhangbiaoti")!=null&&!"".equals(request.getParameter("wenzhangbiaoti"))){
            criteria.andWenzhangbiaotiLike("%"+request.getParameter("wenzhangbiaoti")+"%");
        }
        if(request.getParameter("wenzhangleixing")!=null&&!"".equals(request.getParameter("wenzhangleixing"))) {
            criteria.andWenzhangleixingLike("%"+request.getParameter("wenzhangleixing")+"%");
        }
        Page2<Wenzhang,WenzhangExample> page = new Page2<Wenzhang,WenzhangExample>(wenzhangExample,request.getParameter("currentPage"),request.getParameter("sieze"));
        page = wenzhangService.findWenzhangBySearch(page,user);
        modelAndView.addObject("page",page);
        modelAndView.addObject("wenzhangbiaoti",request.getParameter("wenzhangbiaoti"));
        modelAndView.addObject("wenzhangleixing",request.getParameter("wenzhangleixing"));
        modelAndView.setViewName("/Houtai/ListWenZhangByPage");
        return modelAndView;
    }

    /**
     * 文章分页查找
     *
     * @param request
     * @param response
     * @throws IOException
     * @throws ClientProtocolException
     * @throws net.sf.json.JSONException
     */
    @RequestMapping("/findByPage2.**")
    public void finWenZhangByPage2(HttpServletRequest request, HttpServletResponse response) throws net.sf.json.JSONException, ClientProtocolException, IOException {
        ModelAndView modelAndView = new ModelAndView();
        WenzhangExample wenzhangExample = new WenzhangExample();
		WenzhangExample.Criteria criteria = wenzhangExample.createCriteria();
        User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        if(request.getParameter("wenzhangbiaoti")!=null&&!"".equals(request.getParameter("wenzhangbiaoti"))){
            criteria.andWenzhangbiaotiLike("%"+request.getParameter("wenzhangbiaoti")+"%");
        }
        if(request.getParameter("wenzhangleixing")!=null&&!"".equals(request.getParameter("wenzhangleixing"))) {
            criteria.andWenzhangleixingLike("%"+request.getParameter("wenzhangleixing")+"%");
        }
        Page2<Wenzhang,WenzhangExample> page = new Page2<Wenzhang,WenzhangExample>(wenzhangExample,request.getParameter("currentPage"),request.getParameter("sieze"));
        page = wenzhangService.findWenzhangBySearch(page,user);
        modelAndView.addObject("page",page);
        modelAndView.setViewName("/wenzhang/index");
        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("lists", page.getLists());
            PrintWriter printWriter = new PrintWriter(response.getOutputStream());
            printWriter.print(jsonObject);
            System.out.println(jsonObject);
            printWriter.flush();
            printWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // return modelAndView;
    }

    /**
     * 添加文章
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/addWenZhang.do")
    public ModelAndView addWenZhang(HttpServletRequest request) throws UnsupportedEncodingException {
    	User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
        request.setCharacterEncoding("UTF-8");
        Wenzhang wenZhang = new Wenzhang();
        wenZhang.setWenzhangneirong(request.getParameter("wenzhangneirong"));
        wenZhang.setWenzhangbiaoti(request.getParameter("wenzhangbiaoti"));
        wenZhang.setWenzhangchunwenben(request.getParameter("wenzhangchunwenben").trim());
        wenZhang.setWenzhangleixing(request.getParameter("wenzhangleixing"));
        wenzhangService.addWenzhang(wenZhang,user);
        return new ModelAndView("redirect:/Houtai/findByPage.do");
    }
    @RequestMapping("loginSuccess.do")
	public ModelAndView loginSuccess(ModelAndView modelAndView){
		org.apache.shiro.subject.Subject subject = SecurityUtils.getSubject();
		String userid = (String) subject.getPrincipal();
    	return modelAndView;
	}
}
