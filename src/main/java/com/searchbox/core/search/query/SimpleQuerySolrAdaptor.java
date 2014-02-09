package com.searchbox.core.search.query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.searchbox.anno.SearchAdaptor;
import com.searchbox.core.adaptor.SearchConditionAdaptor;
import com.searchbox.core.adaptor.SearchElementAdaptor;
import com.searchbox.core.engine.SolrQuery;
import com.searchbox.core.engine.SolrResponse;
import com.searchbox.core.search.query.SimpleQuery.Condition;
import com.searchbox.domain.Collection;
import com.searchbox.domain.Preset;
import com.searchbox.web.ApplicationConversionService;

@SearchAdaptor
public class SimpleQuerySolrAdaptor implements SearchConditionAdaptor<SimpleQuery.Condition, SolrQuery>,
	SearchElementAdaptor<SimpleQuery, SolrQuery, SolrResponse> {

	private static Logger logger = LoggerFactory.getLogger(SimpleQuerySolrAdaptor.class);
	@Override
	public SolrQuery doAdapt(Collection collection, SimpleQuery SearchElement,
			SolrQuery query) {
		query.setQuery("*:*");
		return query;
	}

	@Override
	public SimpleQuery doAdapt(Preset preset, SimpleQuery searchElement,
			SolrQuery query, SolrResponse response) {
		searchElement.setQuery(query.getQuery());
		return searchElement;
	}

	@Override
	public SolrQuery doAdapt(Collection collection, Condition condition,
			SolrQuery query) {
		query.setQuery(condition.getQuery());
		return query;
	}

}
