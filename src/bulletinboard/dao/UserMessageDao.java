package bulletinboard.dao;

import static bulletinboard.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import bulletinboard.beans.UserMessage;
import bulletinboard.exception.SQLRuntimeException;

public class UserMessageDao {

	public List<UserMessage> getUserMessages(Connection connection,String startDate,String endDate, String category) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM users_messages ");
			sql.append("WHERE  insert_date >= ? AND insert_date <= ? ");
			if(StringUtils.isBlank(category) == false){
				sql.append(" AND category = ? ");
			}
			sql.append("ORDER BY insert_date DESC");

			ps = connection.prepareStatement(sql.toString());
			ps.setString(1, startDate + " 00:00:00");
			ps.setString(2, endDate + " 23:59:59");
			if(StringUtils.isBlank(category) == false){
				ps.setString(3, category);
			}
			System.out.println(ps);






			ResultSet rs = ps.executeQuery();
			List<UserMessage> ret = toUserMessageList(rs);
			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

	private List<UserMessage> toUserMessageList(ResultSet rs)
			throws SQLException {

		List<UserMessage> ret = new ArrayList<UserMessage>();
		try {
			while (rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String category = rs.getString("category");
				String text = rs.getString("text");
				String name = rs.getString("name");
				int branchId = rs.getInt("branch_id");
				int positionId = rs.getInt("position_id");
				int userId = rs.getInt("user_id");
				Timestamp insertDate = rs.getTimestamp("insert_date");

				UserMessage message = new UserMessage();
				message.setId(id);
				message.setTitle(title);
				message.setCategory(category);
				message.setText(text);
				message.setBranchId(branchId);
				message.setPositionId(positionId);
				message.setUserId(userId);
				message.setName(name);
				message.setInsertDate(insertDate);

				ret.add(message);
			}
			return ret;
		} finally {
			close(rs);
		}
	}

}
