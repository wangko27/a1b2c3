package net.shopxx.directive;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.shopxx.entity.Comment;
import net.shopxx.entity.Goods;
import net.shopxx.service.CommentService;
import net.shopxx.service.GoodsService;
import net.shopxx.util.DirectiveUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import freemarker.core.Environment;
import freemarker.template.ObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component("commentListDirective")
public class CommentListDirective implements TemplateDirectiveModel {
	
	public static final String TAG_NAME = "comment_list";
	private static final String GOODS_ID_PARAMETER_NAME = "goods_id";
	private static final String COUNT_PARAMETER_NAME = "count";
	
	@Resource(name = "commentServiceImpl")
	private CommentService commentService;
	@Resource(name = "goodsServiceImpl")
	private GoodsService goodsService;

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		String goodsId = DirectiveUtil.getStringParameter(GOODS_ID_PARAMETER_NAME, params);
		Integer count = DirectiveUtil.getIntegerParameter(COUNT_PARAMETER_NAME, params);
		
		Goods goods = null;
		if (StringUtils.isNotEmpty(goodsId)) {
			goods = goodsService.load(goodsId);
		}
		List<Comment> commentList = commentService.getCommentList(goods, count);
		
		if (body != null && commentList != null) {
			if (loopVars.length > 0) {
				loopVars[0] = ObjectWrapper.BEANS_WRAPPER.wrap(commentList);
			}
			
			List<Comment> goodCommentList = new ArrayList<Comment>();
			List<Comment> middleCommentList = new ArrayList<Comment>();
			List<Comment> badCommentList = new ArrayList<Comment>();
			for (Comment cmt : commentList) {
				if (cmt.getScore() > 3) {
					goodCommentList.add(cmt);
				} else if (cmt.getScore() < 3) {
					badCommentList.add(cmt);
				} else {
					middleCommentList.add(cmt);
				}
			}
			
			env.setVariable("goodCommentList", ObjectWrapper.DEFAULT_WRAPPER.wrap(goodCommentList));
			env.setVariable("middleCommentList", ObjectWrapper.DEFAULT_WRAPPER.wrap(middleCommentList));
			env.setVariable("badCommentList", ObjectWrapper.DEFAULT_WRAPPER.wrap(badCommentList));
			body.render(env.getOut());
		}
	}

}