package com.sbs.java.blog.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Util {
	public static boolean empty(HttpServletRequest req, String paramName) {
		String paramValue = req.getParameter(paramName);

		return empty(paramValue);
	}

	public static boolean empty(Object obj) {
		if (obj == null) {
			return true;
		}

		if (obj instanceof String) {
			return ((String) obj).trim().length() == 0;
		}

		return true;
	}

	public static boolean isNum(HttpServletRequest req, String paramName) {
		String paramValue = req.getParameter(paramName);

		return isNum(paramValue);
	}
	
//숫자로 받을수 있도록
	public static boolean isNum(Object obj) {
		if (obj == null) {
			return false;
		}

		if (obj instanceof Long) {
			return true;
		} else if (obj instanceof Integer) {
			return true;
		} else if (obj instanceof String) {
			try {
				Integer.parseInt((String) obj);
				return true;
			} catch (NumberFormatException e) {
				return false;
			}
		}

		return false;
	}

	public static int getInt(HttpServletRequest req, String paramName) {
		return Integer.parseInt(req.getParameter(paramName).trim());
	}

	public static void printEx(String errName, HttpServletResponse resp, Exception e) {
		try {
			resp.getWriter()
					.append("<h1 style='color:red; font-weight:bold; text-align:left;'>[에러 : " + errName + "]</h1>");

			resp.getWriter().append("<pre style='text-align:left; font-weight:bold; font-size:1.3rem;'>");
			e.printStackTrace(resp.getWriter());
			resp.getWriter().append("</pre>");
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

	public static int sendMail(String smtpServerId, String smtpServerPw, String from, String fromName, String to, String title,
			String body) {
		Properties prop = System.getProperties();
		prop.put("mail.smtp.starttls.enable", "true");     // gmail은 무조건 true 고정
        prop.put("mail.smtp.host", "smtp.gmail.com");      // smtp 서버 주소
        prop.put("mail.smtp.auth","true");                 // gmail은 무조건 true 고정
        prop.put("mail.smtp.port", "587");                 // gmail 포트

        Authenticator auth = new MailAuth(smtpServerId, smtpServerPw);
        
        Session session = Session.getDefaultInstance(prop, auth);
        
        MimeMessage msg = new MimeMessage(session);
        
        try {
        	msg.setSentDate(new Date());
        	
        	msg.setFrom(new InternetAddress(from, fromName));
        	msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        	msg.setSubject(title, "UTF-8");
        	msg.setText(body, "UTF-8");
        	
        	System.out.println("유틸의 트라이 안");
        	Transport.send(msg);
        	
        } catch (AddressException ae) {
        	System.out.println("AddressException : " + ae.getMessage());
        	return -1;
        } catch (MessagingException me) {
        	System.out.println("MessagingException : " + me.getMessage());
        	return -2;
        } catch (UnsupportedEncodingException e) {
        	System.out.println("UnsupportedEncodingException : " + e.getMessage());
        	return -3;
        }
        
        return 1;
	}

	public static String getString(HttpServletRequest req, String paramName) {
		return req.getParameter(paramName);
	}

	public static String getUrlEncoded(String str) {
		try {
			return URLEncoder.encode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return str;
		}
	}

	public static String getString(HttpServletRequest req, String paramName, String elseValue) {
		if ( req.getParameter(paramName) == null ) {
			return elseValue;
		}
		
		if ( req.getParameter(paramName).trim().length() == 0 ) {
			return elseValue;
		}
		
		return getString(req, paramName);
	}
}