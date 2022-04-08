package com.mos;

import java.util.Calendar;
import java.util.Date;

public class CalendarCal {
	
	private static final int since = 1981;
	
	public static int getYear() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		return cal.get(Calendar.YEAR) - since;
	}
}
