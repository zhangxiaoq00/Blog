package com.zyc.model;

public class User {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column User.id
     *
     * @mbg.generated
     */
    private Integer id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column User.username
     *
     * @mbg.generated
     */
    private String username;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column User.userpassword
     *
     * @mbg.generated
     */
    private String userpassword;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column User.usermail
     *
     * @mbg.generated
     */
    private String usermail;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column User.usertype
     *
     * @mbg.generated
     */
    private Integer usertype;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table User
     *
     * @mbg.generated
     */
    public User(Integer id, String username, String userpassword, String usermail, Integer usertype) {
        this.id = id;
        this.username = username;
        this.userpassword = userpassword;
        this.usermail = usermail;
        this.usertype = usertype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table User
     *
     * @mbg.generated
     */
    public User() {
        super();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column User.id
     *
     * @return the value of User.id
     *
     * @mbg.generated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column User.id
     *
     * @param id the value for User.id
     *
     * @mbg.generated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column User.username
     *
     * @return the value of User.username
     *
     * @mbg.generated
     */
    public String getUsername() {
        return username;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column User.username
     *
     * @param username the value for User.username
     *
     * @mbg.generated
     */
    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column User.userpassword
     *
     * @return the value of User.userpassword
     *
     * @mbg.generated
     */
    public String getUserpassword() {
        return userpassword;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column User.userpassword
     *
     * @param userpassword the value for User.userpassword
     *
     * @mbg.generated
     */
    public void setUserpassword(String userpassword) {
        this.userpassword = userpassword == null ? null : userpassword.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column User.usermail
     *
     * @return the value of User.usermail
     *
     * @mbg.generated
     */
    public String getUsermail() {
        return usermail;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column User.usermail
     *
     * @param usermail the value for User.usermail
     *
     * @mbg.generated
     */
    public void setUsermail(String usermail) {
        this.usermail = usermail == null ? null : usermail.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column User.usertype
     *
     * @return the value of User.usertype
     *
     * @mbg.generated
     */
    public Integer getUsertype() {
        return usertype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column User.usertype
     *
     * @param usertype the value for User.usertype
     *
     * @mbg.generated
     */
    public void setUsertype(Integer usertype) {
        this.usertype = usertype;
    }
}