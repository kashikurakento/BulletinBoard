package bulletinboard.dao;

import static bulletinboard.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bulletinboard.beans.Branch;
import bulletinboard.exception.SQLRuntimeException;

public class BranchDao {

	public List<Branch> getBranch(Connection connection) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM branches ");
			sql.append("ORDER BY insert_date ASC ");

			ps = connection.prepareStatement(sql.toString());

			ResultSet rs = ps.executeQuery();
			List<Branch> ret = toBranchList(rs);
			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

	private List<Branch> toBranchList(ResultSet rs)
			throws SQLException {

		List<Branch> ret = new ArrayList<Branch>();
		try {
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				Timestamp insertDate = rs.getTimestamp("insert_date");

				Branch branch = new Branch();
				branch.setId(id);
				branch.setName(name);
				branch.setInsertDate(insertDate);

				ret.add(branch);
			}
			return ret;
		} finally {
			close(rs);
		}
	}

}
