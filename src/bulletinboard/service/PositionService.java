package bulletinboard.service;

import static bulletinboard.utils.CloseableUtil.*;
import static bulletinboard.utils.DBUtil.*;

import java.sql.Connection;
import java.util.List;

import bulletinboard.beans.Position;
import bulletinboard.dao.PositionDao;

public class PositionService {

	public List<Position> getPosition() {


		Connection connection = null;
		try {
			connection = getConnection();

			PositionDao positionDao = new PositionDao();
			List<Position> position = positionDao.getPosition(connection);

			commit(connection);

			return position;
		} catch (RuntimeException e) {
			rollback(connection);
			throw e;
		} catch (Error e) {
			rollback(connection);
			throw e;
		} finally {
			close(connection);
		}
	}


}
