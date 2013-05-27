<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 
参数：
itemPerPage 可选，默认20
curpage 可选，默认0
navCount 数据量
navUrl 当前url
navUrlEnd 可选，附加的参数
 --%>

<c:if test="${empty itemPerPage}" >
	<c:set var="itemPerPage" value="20" />
</c:if>
<c:choose>
	<c:when test="${empty curpage}">
		<c:set var="currentPage" value="0"/>
	</c:when>
	<c:otherwise>
		<c:set var="currentPage" value="${curpage}"/> 
	</c:otherwise>
</c:choose>
<c:set var="navCount" value="${navCount}"/>
<c:set var="numberMod" value="${navCount % itemPerPage}"/>
<c:set var="countInt" value="${navCount-numberMod}"/>
<c:choose>
	<c:when test="${numberMod==0}">
		<fmt:parseNumber parseLocale="en_US" value="${countInt/itemPerPage}" integerOnly="true" var="pageNum" />
	</c:when>
	<c:otherwise>
		<fmt:parseNumber parseLocale="en_US" value="${countInt/itemPerPage + 1}" integerOnly="true" var="pageNum" />
	</c:otherwise>
</c:choose>


<div id="divAlbumListPage">
<c:if test="${pageNum > 1}">
<c:choose>
<c:when test="${pageNum<7}">
	<c:if test="${currentPage<pageNum-1}">
		<span class="divAlbumPageLink"><a class="pager" title="下一页" href="${navUrl}?curpage=${currentPage+1}${navUrlEnd}">下一页</a></span>
	</c:if>
	<c:if test="${currentPage<pageNum-5}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+6}页" href="${navUrl}?curpage=${currentPage+5}${navUrlEnd}">${currentPage+6}</a></span>
	</c:if>
	<c:if test="${currentPage<pageNum-4}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+5}页" href="${navUrl}?curpage=${currentPage+4}${navUrlEnd}">${currentPage+5}</a></span>
	</c:if>
	<c:if test="${currentPage<pageNum-3}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+4}页" href="${navUrl}?curpage=${currentPage+3}${navUrlEnd}">${currentPage+4}</a></span>
	</c:if>
	<c:if test="${currentPage<pageNum-2}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+3}页" href="${navUrl}?curpage=${currentPage+2}${navUrlEnd}">${currentPage+3}</a></span>
	</c:if>	
	<c:if test="${currentPage<pageNum-1}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+2}页" href="${navUrl}?curpage=${currentPage+1}${navUrlEnd}">${currentPage+2}</a></span>
	</c:if>	
	<span class="current">${currentPage+1}</span>	
	<c:if test="${currentPage>0}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage}页" href="${navUrl}?curpage=${currentPage-1}${navUrlEnd}">${currentPage}</a></span>
	</c:if>	
	<c:if test="${currentPage>1}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage-1}页" href="${navUrl}?curpage=${currentPage-2}${navUrlEnd}">${currentPage-1}</a></span>
	</c:if>	
	<c:if test="${currentPage>2}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage-2}页" href="${navUrl}?curpage=${currentPage-3}${navUrlEnd}">${currentPage-2}</a></span>
	</c:if>	
	<c:if test="${currentPage>3}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage-3}页" href="${navUrl}?curpage=${currentPage-4}${navUrlEnd}">${currentPage-3}</a></span>
	</c:if>	
	<c:if test="${currentPage>4}">
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage-4}页" href="${navUrl}?curpage=${currentPage-5}${navUrlEnd}">${currentPage-4}</a></span>
	</c:if>	
	<c:if test="${currentPage>0}">
		<span class="divAlbumPageLink"><a class="pager" title="上一页"  href="${navUrl}?curpage=${currentPage-1}${navUrlEnd}">上一页</a></span>
	</c:if>	
</c:when>
<c:when test="${pageNum>6}">
	<c:if test="${currentPage>-1 && currentPage<pageNum-3}">
		<span class="divAlbumPageLink"><a class="pager" title="最后页" href="${navUrl}?curpage=${pageNum-1}${navUrlEnd}">尾页</a></span>
		<span class="divAlbumPageLink"><a class="pager" title="下一页" href="${navUrl}?curpage=${currentPage+1}${navUrlEnd}">下一页</a></span>
		<c:if test="${currentPage<1}">
			<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+5}" href="${navUrl}?curpage=${currentPage+4}${navUrlEnd}">${currentPage+5}</a></span>
		</c:if>
		<c:if test="${currentPage<2}">
			<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+4}" href="${navUrl}?curpage=${currentPage+3}${navUrlEnd}">${currentPage+4}</a></span>
		</c:if>
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+3}" href="${navUrl}?curpage=${currentPage+2}${navUrlEnd}">${currentPage+3}</a></span>
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+2}" href="${navUrl}?curpage=${currentPage+1}${navUrlEnd}">${currentPage+2}</a></span>
		<span class="current">${currentPage+1}</span>
		<c:if test="${currentPage>0}">
			<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage}" href="${navUrl}?curpage=${currentPage-1}${navUrlEnd}">${currentPage}</a></span>
		</c:if>
		<c:if test="${currentPage>1}">
			<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage-1}" href="${navUrl}?curpage=${currentPage-2}${navUrlEnd}">${currentPage-1}</a></span>
		</c:if>
		<c:if test="${currentPage>0}">
			<span class="divAlbumPageLink"><a class="pager" title="上一页" href="${navUrl}?curpage=${currentPage-1}${navUrlEnd}">上一页</a></span>
		</c:if>
		<c:if test="${currentPage>2}">
			<span class="divAlbumPageLink"><a class="pager" title="最前页" href="${navUrl}?curpage=0${navUrlEnd}">首页</a></span>
		</c:if>
	</c:if>
	<c:if test="${(currentPage < pageNum - 0)&&(currentPage>pageNum-4)}">
		<c:if test="${currentPage<pageNum-3}">
			<span class="divAlbumPageLink"><a class="pager" title="最后页" href="${navUrl}?curpage=${pageNum-1}${navUrlEnd}">尾页</a></span>
		</c:if>
		<c:if test="${currentPage<pageNum-1}">
			<span class="divAlbumPageLink"><a class="pager" title="下一页" href="${navUrl}?curpage=${currentPage+1}${navUrlEnd}">下一页</a></span>
		</c:if>
		<c:if test="${currentPage<pageNum-2}">
			<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+3}" href="${navUrl}?curpage=${currentPage+2}${navUrlEnd}">${currentPage+3}</a></span>
		</c:if>
		<c:if test="${currentPage<pageNum-1}">
			<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage+2}" href="${navUrl}?curpage=${currentPage+1}${navUrlEnd}">${currentPage+2}</a></span>
		</c:if>
		<span class="current">${currentPage+1}</span>
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage}" href="${navUrl}?curpage=${currentPage-1}${navUrlEnd}">${currentPage}</a></span>
		<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage-1}" href="${navUrl}?curpage=${currentPage-2}${navUrlEnd}">${currentPage-1}</a></span>
		<c:if test="${currentPage>pageNum-3}">
			<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage-2}" href="${navUrl}?curpage=${currentPage-3}${navUrlEnd}">${currentPage-2}</a></span>
		</c:if>
		<c:if test="${currentPage>pageNum-2}">
			<span class="divAlbumPageLink"><a class="pager" title="跳到第${currentPage-3}" href="${navUrl}?curpage=${currentPage-4}${navUrlEnd}">${currentPage-3}</a></span>
		</c:if>
		<span class="divAlbumPageLink"><a class="pager" title="上一页" href="${navUrl}?curpage=${currentPage-1}${navUrlEnd}">上一页</a></span>
		<span class="divAlbumPageLink"><a class="pager" title="最前页" href="${navUrl}?curpage=0${navUrlEnd}">首页</a></span>
	</c:if>
</c:when>
</c:choose>
</c:if>
</div>
