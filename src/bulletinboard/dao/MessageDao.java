package bulletinboard.dao;

import static bulletinboard.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bulletinboard.beans.Message;
import bulletinboard.exception.NoRowsUpdatedRuntimeException;
import bulletinboard.exception.SQLRuntimeException;

public class MessageDao {

	public void insert(Connection connection, Message message) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO messages ( ");
			sql.append(" title");
			sql.append(", text");
			sql.append(", category");
			sql.append(", branch_id");
			sql.append(", position_id");
			sql.append(", user_id");
			sql.append(", insert_date");
			sql.append(", update_date");
			sql.append(") VALUES (");
			sql.append("  ?"); // title
			sql.append(", ?"); // text
			sql.append(", ?"); // category
			sql.append(", ?"); // branch_id
			sql.append(", ?"); // position_id
			sql.append(", ?"); // user_id
			sql.append(", CURRENT_TIMESTAMP"); // insert_date
			sql.append(", CURRENT_TIMESTAMP"); // update_date
			sql.append(")");

			ps = connection.prepareStatement(sql.toString());
			ps.setString(1, message.getTitle());
			ps.setString(2, message.getText());
			ps.setString(3, message.getCategory());
			ps.setInt(4, message.getBranchId());
			ps.setInt(5, message.getPositionId());
			ps.setInt(6, message.getUserId());

			ps.executeUpdate();
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

	public void messageDelete(Connection connection, int id) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("DELETE FROM messages WHERE id = ?");

			ps = connection.prepareStatement(sql.toString());

			ps.setInt(1, id);

			int count = ps.executeUpdate();
			if (count == 0) {
				throw new NoRowsUpdatedRuntimeException();
			}
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

/*
	public List<Message> getUserMessages(Connection connection, int num) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT ");
			sql.append(" title");
			sql.append(", category");
			sql.append(", text");
			sql.append(", insert_date ");
			sql.append("FROM messages ");
			sql.append("ORDER BY insert_date DESC limit " + num);

			System.out.println(sql);

			ps = connection.prepareStatement(sql.toString());

			ResultSet rs = ps.executeQuery();
			List<Message> ret = toMessageList(rs);
			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

	private List<Message> toMessageList(ResultSet rs)
			throws SQLException {

		List<Message> ret = new ArrayList<Message>();
		try {
			while (rs.next()) {
				String title = rs.getString("title");
				String category = rs.getString("category");
				//int id = rs.getInt("id");
				String text = rs.getString("text");
				Timestamp insertDate = rs.getTimestamp("insert_date");

				Message message = new Message();
				message.setTitle(title);
				message.setCategory(category);
				message.setText(text);
				message.setInsertDate(insertDate);

				ret.add(message);
			}
			return ret;
		} finally {
			close(rs);
		}
	}
*/
}
