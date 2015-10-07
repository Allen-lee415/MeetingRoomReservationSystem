package com.servlet;

import java.util.Random;

import com.ssh.hibernate.MeetinginfoDAO;

public class DataUtils {
	static MeetinginfoDAO mdaoC;
	
public MeetinginfoDAO getMdaoC() {
		return mdaoC;
	}
	public void setMdaoC(MeetinginfoDAO mdaoC) {
		this.mdaoC = mdaoC;
	}
public static int getData1(){

   //在那里写一个函数查一下meeting1被预约的总次数，这个再写一个meeting1 zhangsan预约的次数，用于柱图
    int num=mdaoC.countChart(1); 
	return num;
}

public static int getData2(){
	 int num=mdaoC.countChart(2); 
		return num;
}
public static int getData3(){
	 int num=mdaoC.countChart(3); 
		return num;
}
public static int getData4(){
	 int num=mdaoC.countChart(4); 
		return num;
}
public static int getData5(){
	 int num=mdaoC.countChart(5); 
		return num;
}

//柱状图部分
private static Random random=new Random();
private static final int MAX_NUMBER=100;
public static int getBarData(String cat,String category){
	System.out.println(cat);
	System.out.println(category);
	char num=cat.charAt(11);System.out.println(num);
   return mdaoC.countBarChart(cat,category);
}

}
