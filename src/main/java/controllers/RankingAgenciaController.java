package controllers;

import java.util.List;

import daos.RankingAgenciaDao;
import models.RankingAgencia;

public class RankingAgenciaController {

	public List<RankingAgencia> getRankingLocal(int limit) {
		return RankingAgenciaDao.getRankingAgencia(limit);
	}
}
