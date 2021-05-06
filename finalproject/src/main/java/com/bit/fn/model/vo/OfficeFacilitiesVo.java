package com.bit.fn.model.vo;

public class OfficeFacilitiesVo {
	private int officeNum;
	private String desk,chair,modem, fireExtinguisher, lan, airConditioner, radiator, descendingLifeLine, powerSocket;
	public OfficeFacilitiesVo() {}
	public OfficeFacilitiesVo(int officeNum, String desk, String chair, String modem, String fireExtinguisher,
			String lan, String airConditioner, String radiator, String descendingLifeLine, String powerSocket) {
		super();
		this.officeNum = officeNum;
		this.desk = desk;
		this.chair = chair;
		this.modem = modem;
		this.fireExtinguisher = fireExtinguisher;
		this.lan = lan;
		this.airConditioner = airConditioner;
		this.radiator = radiator;
		this.descendingLifeLine = descendingLifeLine;
		this.powerSocket = powerSocket;
	}
	
	public String getFireExtinguisher() {
		return fireExtinguisher;
	}
	public void setFireExtinguisher(String fireExtinguisher) {
		this.fireExtinguisher = fireExtinguisher;
	}
	public String getLan() {
		return lan;
	}
	public void setLan(String lan) {
		this.lan = lan;
	}
	public String getAirConditioner() {
		return airConditioner;
	}
	public void setAirConditioner(String airConditioner) {
		this.airConditioner = airConditioner;
	}
	public String getRadiator() {
		return radiator;
	}
	public void setRadiator(String radiator) {
		this.radiator = radiator;
	}
	public String getDescendingLifeLine() {
		return descendingLifeLine;
	}
	public void setDescendingLifeLine(String descendingLifeLine) {
		this.descendingLifeLine = descendingLifeLine;
	}
	public String getPowerSocket() {
		return powerSocket;
	}
	public void setPowerSocket(String powerSocket) {
		this.powerSocket = powerSocket;
	}
	public int getOfficeNum() {
		return officeNum;
	}
	public void setOfficeNum(int officeNum) {
		this.officeNum = officeNum;
	}
	public String getDesk() {
		return desk;
	}
	public void setDesk(String desk) {
		this.desk = desk;
	}
	public String getChair() {
		return chair;
	}
	public void setChair(String chair) {
		this.chair = chair;
	}
	public String getModem() {
		return modem;
	}
	public void setModem(String modem) {
		this.modem = modem;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((airConditioner == null) ? 0 : airConditioner.hashCode());
		result = prime * result + ((chair == null) ? 0 : chair.hashCode());
		result = prime * result + ((descendingLifeLine == null) ? 0 : descendingLifeLine.hashCode());
		result = prime * result + ((desk == null) ? 0 : desk.hashCode());
		result = prime * result + ((fireExtinguisher == null) ? 0 : fireExtinguisher.hashCode());
		result = prime * result + ((lan == null) ? 0 : lan.hashCode());
		result = prime * result + ((modem == null) ? 0 : modem.hashCode());
		result = prime * result + officeNum;
		result = prime * result + ((powerSocket == null) ? 0 : powerSocket.hashCode());
		result = prime * result + ((radiator == null) ? 0 : radiator.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OfficeFacilitiesVo other = (OfficeFacilitiesVo) obj;
		if (airConditioner == null) {
			if (other.airConditioner != null)
				return false;
		} else if (!airConditioner.equals(other.airConditioner))
			return false;
		if (chair == null) {
			if (other.chair != null)
				return false;
		} else if (!chair.equals(other.chair))
			return false;
		if (descendingLifeLine == null) {
			if (other.descendingLifeLine != null)
				return false;
		} else if (!descendingLifeLine.equals(other.descendingLifeLine))
			return false;
		if (desk == null) {
			if (other.desk != null)
				return false;
		} else if (!desk.equals(other.desk))
			return false;
		if (fireExtinguisher == null) {
			if (other.fireExtinguisher != null)
				return false;
		} else if (!fireExtinguisher.equals(other.fireExtinguisher))
			return false;
		if (lan == null) {
			if (other.lan != null)
				return false;
		} else if (!lan.equals(other.lan))
			return false;
		if (modem == null) {
			if (other.modem != null)
				return false;
		} else if (!modem.equals(other.modem))
			return false;
		if (officeNum != other.officeNum)
			return false;
		if (powerSocket == null) {
			if (other.powerSocket != null)
				return false;
		} else if (!powerSocket.equals(other.powerSocket))
			return false;
		if (radiator == null) {
			if (other.radiator != null)
				return false;
		} else if (!radiator.equals(other.radiator))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "OfficeFacilitiesVo [officeNum=" + officeNum + ", desk=" + desk + ", chair=" + chair + ", modem=" + modem
				+ ", fireExtinguisher=" + fireExtinguisher + ", lan=" + lan + ", airConditioner=" + airConditioner
				+ ", radiator=" + radiator + ", descendingLifeLine=" + descendingLifeLine + ", powerSocket="
				+ powerSocket + "]";
	}
}