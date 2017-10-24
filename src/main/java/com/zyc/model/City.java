package com.zyc.model;

public class City {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.ID
     *
     * @mbg.generated
     */
    private Integer id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.Name
     *
     * @mbg.generated
     */
    private String name;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.ParentId
     *
     * @mbg.generated
     */
    private Integer parentid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.ShortName
     *
     * @mbg.generated
     */
    private String shortname;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.LevelType
     *
     * @mbg.generated
     */
    private Integer leveltype;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.CityCode
     *
     * @mbg.generated
     */
    private String citycode;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.ZipCode
     *
     * @mbg.generated
     */
    private String zipcode;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.MergerName
     *
     * @mbg.generated
     */
    private String mergername;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.lng
     *
     * @mbg.generated
     */
    private Float lng;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.Lat
     *
     * @mbg.generated
     */
    private Float lat;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column City.Pinyin
     *
     * @mbg.generated
     */
    private String pinyin;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    public City(Integer id, String name, Integer parentid, String shortname, Integer leveltype, String citycode, String zipcode, String mergername, Float lng, Float lat, String pinyin) {
        this.id = id;
        this.name = name;
        this.parentid = parentid;
        this.shortname = shortname;
        this.leveltype = leveltype;
        this.citycode = citycode;
        this.zipcode = zipcode;
        this.mergername = mergername;
        this.lng = lng;
        this.lat = lat;
        this.pinyin = pinyin;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table City
     *
     * @mbg.generated
     */
    public City() {
        super();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.ID
     *
     * @return the value of City.ID
     *
     * @mbg.generated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.ID
     *
     * @param id the value for City.ID
     *
     * @mbg.generated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.Name
     *
     * @return the value of City.Name
     *
     * @mbg.generated
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.Name
     *
     * @param name the value for City.Name
     *
     * @mbg.generated
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.ParentId
     *
     * @return the value of City.ParentId
     *
     * @mbg.generated
     */
    public Integer getParentid() {
        return parentid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.ParentId
     *
     * @param parentid the value for City.ParentId
     *
     * @mbg.generated
     */
    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.ShortName
     *
     * @return the value of City.ShortName
     *
     * @mbg.generated
     */
    public String getShortname() {
        return shortname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.ShortName
     *
     * @param shortname the value for City.ShortName
     *
     * @mbg.generated
     */
    public void setShortname(String shortname) {
        this.shortname = shortname == null ? null : shortname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.LevelType
     *
     * @return the value of City.LevelType
     *
     * @mbg.generated
     */
    public Integer getLeveltype() {
        return leveltype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.LevelType
     *
     * @param leveltype the value for City.LevelType
     *
     * @mbg.generated
     */
    public void setLeveltype(Integer leveltype) {
        this.leveltype = leveltype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.CityCode
     *
     * @return the value of City.CityCode
     *
     * @mbg.generated
     */
    public String getCitycode() {
        return citycode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.CityCode
     *
     * @param citycode the value for City.CityCode
     *
     * @mbg.generated
     */
    public void setCitycode(String citycode) {
        this.citycode = citycode == null ? null : citycode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.ZipCode
     *
     * @return the value of City.ZipCode
     *
     * @mbg.generated
     */
    public String getZipcode() {
        return zipcode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.ZipCode
     *
     * @param zipcode the value for City.ZipCode
     *
     * @mbg.generated
     */
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode == null ? null : zipcode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.MergerName
     *
     * @return the value of City.MergerName
     *
     * @mbg.generated
     */
    public String getMergername() {
        return mergername;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.MergerName
     *
     * @param mergername the value for City.MergerName
     *
     * @mbg.generated
     */
    public void setMergername(String mergername) {
        this.mergername = mergername == null ? null : mergername.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.lng
     *
     * @return the value of City.lng
     *
     * @mbg.generated
     */
    public Float getLng() {
        return lng;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.lng
     *
     * @param lng the value for City.lng
     *
     * @mbg.generated
     */
    public void setLng(Float lng) {
        this.lng = lng;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.Lat
     *
     * @return the value of City.Lat
     *
     * @mbg.generated
     */
    public Float getLat() {
        return lat;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.Lat
     *
     * @param lat the value for City.Lat
     *
     * @mbg.generated
     */
    public void setLat(Float lat) {
        this.lat = lat;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column City.Pinyin
     *
     * @return the value of City.Pinyin
     *
     * @mbg.generated
     */
    public String getPinyin() {
        return pinyin;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column City.Pinyin
     *
     * @param pinyin the value for City.Pinyin
     *
     * @mbg.generated
     */
    public void setPinyin(String pinyin) {
        this.pinyin = pinyin == null ? null : pinyin.trim();
    }
}