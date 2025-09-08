package controllers;

import java.util.List;

import models.RankingLocal;
import daos.RankingLocalDao;

public class RankingLocalController {

	public List<RankingLocal> getRankingLocal(int limit) {
		return RankingLocalDao.getRankingLocais(limit);
	}
}
