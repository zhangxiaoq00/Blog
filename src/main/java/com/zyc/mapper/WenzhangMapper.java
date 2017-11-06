package com.zyc.mapper;

import com.zyc.model.Wenzhang;
import com.zyc.model.WenzhangExample;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;
public interface WenzhangMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    long countByExample(WenzhangExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    int deleteByExample(WenzhangExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    @Delete({
        "delete from wenzhang",
        "where wenzhangid = #{wenzhangid,jdbcType=INTEGER}"
    })
    int deleteByPrimaryKey(Integer wenzhangid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    @Insert({
        "insert into wenzhang (wenzhangid, wenzhangleixing, ",
        "wenzhangbiaoti, wenzhangneirong, ",
        "wenzhangchunwenben, wenzhangriqi, ",
        "wenzhangauthor)",
        "values (#{wenzhangid,jdbcType=INTEGER}, #{wenzhangleixing,jdbcType=VARCHAR}, ",
        "#{wenzhangbiaoti,jdbcType=VARCHAR}, #{wenzhangneirong,jdbcType=VARCHAR}, ",
        "#{wenzhangchunwenben,jdbcType=VARCHAR}, #{wenzhangriqi,jdbcType=TIMESTAMP}, ",
        "#{wenzhangauthor,jdbcType=INTEGER})"
    })
    int insert(Wenzhang record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    int insertSelective(Wenzhang record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    List<Wenzhang> selectByExample(WenzhangExample example);

    List<Wenzhang> selectByExampleLeftSub(WenzhangExample example);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    @Select({
        "select",
        "wenzhangid, wenzhangleixing, wenzhangbiaoti, wenzhangneirong, wenzhangchunwenben, ",
        "wenzhangriqi, wenzhangauthor",
        "from wenzhang",
        "where wenzhangid = #{wenzhangid,jdbcType=INTEGER}"
    })
    @ResultMap("com.zyc.mapper.WenzhangMapper.BaseResultMap")
    Wenzhang selectByPrimaryKey(Integer wenzhangid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    int updateByExampleSelective(@Param("record") Wenzhang record, @Param("example") WenzhangExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    int updateByExample(@Param("record") Wenzhang record, @Param("example") WenzhangExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    int updateByPrimaryKeySelective(Wenzhang record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table wenzhang
     *
     * @mbg.generated
     */
    @Update({
        "update wenzhang",
        "set wenzhangleixing = #{wenzhangleixing,jdbcType=VARCHAR},",
          "wenzhangbiaoti = #{wenzhangbiaoti,jdbcType=VARCHAR},",
          "wenzhangneirong = #{wenzhangneirong,jdbcType=VARCHAR},",
          "wenzhangchunwenben = #{wenzhangchunwenben,jdbcType=VARCHAR},",
          "wenzhangriqi = #{wenzhangriqi,jdbcType=TIMESTAMP},",
          "wenzhangauthor = #{wenzhangauthor,jdbcType=INTEGER}",
        "where wenzhangid = #{wenzhangid,jdbcType=INTEGER}"
    })
    int updateByPrimaryKey(Wenzhang record);
}