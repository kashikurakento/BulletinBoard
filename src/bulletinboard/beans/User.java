package bulletinboard.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;
	private String loginId;
	private String password;
	private String name;
	private int branchId;
	private int positionId;
	private int isWorking;
	private Timestamp insertDate;
	private Timestamp updateDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String login_id) {
		this.loginId = login_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getBranchId() {
		return branchId;
	}

	public void setBranchId(Integer branch_id) {
		this.branchId = branch_id;
	}

	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer position_id) {
		this.positionId = position_id;
	}

	public Integer getIsWorking() {
		return isWorking;
	}

	public void setIsWorking(Integer is_working) {
		this.isWorking = is_working;
	}

	public Timestamp getInsertDate() {
		return insertDate;
	}

	public void setInsertDate(Timestamp insertDate2) {
		this.insertDate = insertDate2;
	}

	public Timestamp getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Timestamp updateDate2) {
		this.updateDate = updateDate2;
	}

}
