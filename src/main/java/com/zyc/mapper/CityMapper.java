package com.zyc.mapper;

import com.zyc.model.City;
import com.zyc.model.CityExample;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;
public interface CityMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    long countByExample(CityExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    int deleteByExample(CityExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    @Delete({
        "delete from City",
        "where ID = #{id,jdbcType=INTEGER}"
    })
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    @Insert({
        "insert into City (ID, CityName, ",
        "ParentID, ShortName, ",
        "LevelType, CityCode, ",
        "ZipCode, MergerName, ",
        "lng, Lat, PinYin, ",
        "insideflag)",
        "values (#{id,jdbcType=INTEGER}, #{cityname,jdbcType=VARCHAR}, ",
        "#{parentid,jdbcType=INTEGER}, #{shortname,jdbcType=VARCHAR}, ",
        "#{leveltype,jdbcType=INTEGER}, #{citycode,jdbcType=VARCHAR}, ",
        "#{zipcode,jdbcType=VARCHAR}, #{mergername,jdbcType=VARCHAR}, ",
        "#{lng,jdbcType=REAL}, #{lat,jdbcType=REAL}, #{pinyin,jdbcType=VARCHAR}, ",
        "#{insideflag,jdbcType=BIT})"
    })
    int insert(City record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    int insertSelective(City record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    List<City> selectByExample(CityExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    @Select({
        "select",
        "ID, CityName, ParentID, ShortName, LevelType, CityCode, ZipCode, MergerName, ",
        "lng, Lat, PinYin, insideflag",
        "from City",
        "where ID = #{id,jdbcType=INTEGER}"
    })
    @ResultMap("com.zyc.mapper.CityMapper.BaseResultMap")
    City selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    int updateByExampleSelective(@Param("record") City record, @Param("example") CityExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    int updateByExample(@Param("record") City record, @Param("example") CityExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    int updateByPrimaryKeySelective(City record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    @Update({
        "update City",
        "set CityName = #{cityname,jdbcType=VARCHAR},",
          "ParentID = #{parentid,jdbcType=INTEGER},",
          "ShortName = #{shortname,jdbcType=VARCHAR},",
          "LevelType = #{leveltype,jdbcType=INTEGER},",
          "CityCode = #{citycode,jdbcType=VARCHAR},",
          "ZipCode = #{zipcode,jdbcType=VARCHAR},",
          "MergerName = #{mergername,jdbcType=VARCHAR},",
          "lng = #{lng,jdbcType=REAL},",
          "Lat = #{lat,jdbcType=REAL},",
          "PinYin = #{pinyin,jdbcType=VARCHAR},",
          "insideflag = #{insideflag,jdbcType=BIT}",
        "where ID = #{id,jdbcType=INTEGER}"
    })
    int updateByPrimaryKey(City record);
}