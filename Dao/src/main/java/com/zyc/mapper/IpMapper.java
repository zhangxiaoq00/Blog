package com.zyc.mapper;

import com.zyc.model.GroupCount;
import com.zyc.model.Ip;
import com.zyc.model.IpExample;
import com.zyc.model.Ip_Date;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface IpMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    long countByExample(IpExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    int deleteByExample(IpExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    @Delete({
        "delete from IP",
        "where ipid = #{ipid,jdbcType=INTEGER}"
    })
    int deleteByPrimaryKey(Integer ipid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    @Insert({
        "insert into IP (ipid, ip, ",
        "location, x, y, ",
        "date)",
        "values (#{ipid,jdbcType=INTEGER}, #{ip,jdbcType=VARCHAR}, ",
        "#{location,jdbcType=VARCHAR}, #{x,jdbcType=VARCHAR}, #{y,jdbcType=VARCHAR}, ",
        "#{date,jdbcType=TIMESTAMP})"
    })
    int insert(Ip record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    int insertSelective(Ip record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    List<Ip> selectByExample(IpExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    @Select({
        "select",
        "ipid, ip, location, x, y, date",
        "from IP",
        "where ipid = #{ipid,jdbcType=INTEGER}"
    })
    @ResultMap("com.zyc.mapper.IpMapper.BaseResultMap")
    Ip selectByPrimaryKey(Integer ipid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    int updateByExampleSelective(@Param("record") Ip record, @Param("example") IpExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    int updateByExample(@Param("record") Ip record, @Param("example") IpExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    int updateByPrimaryKeySelective(Ip record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table IP
     *
     * @mbg.generated
     */
    @Update({
        "update IP",
        "set ip = #{ip,jdbcType=VARCHAR},",
          "location = #{location,jdbcType=VARCHAR},",
          "x = #{x,jdbcType=VARCHAR},",
          "y = #{y,jdbcType=VARCHAR},",
          "date = #{date,jdbcType=TIMESTAMP}",
        "where ipid = #{ipid,jdbcType=INTEGER}"
    })
    int updateByPrimaryKey(Ip record);

    List<Ip_Date> selectCountByDay(Integer count);

    List<GroupCount> selectCountByX();
}