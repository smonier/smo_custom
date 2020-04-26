<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%@ taglib prefix="cl" uri="http://www.jahia.org/tags/cloudinary" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="newsTitle"/>
<jcr:nodeProperty node="${currentNode}" name="date" var="newsDate"/>
<jcr:nodeProperty node="${currentNode}" name="desc" var="newsDesc"/>
<jcr:nodeProperty node="${currentNode}" name="image" var="newsImage"/>

<jcr:nodeProperty node="${currentNode}" var="newsCategories" name="j:defaultCategory"/>
<c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
<jahia:addCacheDependency node="${newsImage.node}" />

<div class="card mt-3 mb-3">
  <h2 class="card-title">${fn:escapeXml(newsTitle.string)}</h2>
    <c:if test="${not empty newsImage}">
        <jahia:addCacheDependency node="${newsImage.node}" />
        <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
        <div class="newsImg">
            <a href="<c:url value='${url.base}${currentNode.path}.html'/>">
                <c:choose>
                    <c:when test="${jcr:isNodeType(renderContext.site, 'cldin:configuration')}">

                        <c:set var="gravity" value="auto"/>
                        <c:set var="crop" value="fill"/>
                        <c:set var="raw" value=""/>

                        <img src="<cl:url node='${newsImage.node}' width="768" gravity="${gravity}" crop="${crop}" raw="${raw}"/>"
                             srcset="<cl:url node="${newsImage.node}" width="256" crop="${crop}" gravity="${gravity}" raw="${raw}"/> 256w,
                            <cl:url node="${newsImage.node}" width="512" gravity="${gravity}" crop="${crop}" raw="${raw}"/> 512w,
                            <cl:url node="${newsImage.node}" width="768" gravity="${gravity}" crop="${crop}" raw="${raw}"/> 768w,
                            <cl:url node="${newsImage.node}" width="1024" gravity="${gravity}" crop="${crop}" raw="${raw}"/> 1024w,
                            <cl:url node="${newsImage.node}" width="1280" gravity="${gravity}" crop="${crop}" raw="${raw}"/> 1280w,
                            <cl:url node="${newsImage.node}" width="1600" gravity="${gravity}" crop="${crop}" raw="${raw}"/> 1600w,
                            <cl:url node="${newsImage.node}" width="2000" gravity="${gravity}" crop="${crop}" raw="${raw}"/> 2000w"
                             class="card-img-top"
                             alt="${fn:escapeXml(not empty newsTitle.string ? newsTitle.string : currentNode.name)}"
                        />

                    </c:when>
                    <c:otherwise>
                        <img class="card-img-top" src="${imageUrl}" alt=""${newsTitle}" width="100%">
                    </c:otherwise>
                </c:choose>
            </a>
        </div>
    </c:if>

  <div class="card-body">
    <p class="card-text">
    <c:if test="${!empty newsCategories }">
        <div class="newsMeta">
            <span class="categoryLabel"><fmt:message key='label.categories'/> :</span>
            <jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>
            <c:if test="${cat != null}">
                <c:forEach items="${cat}" var="category">
                    <span class="categorytitle">${category.node.displayableName}</span>
                </c:forEach>

            </c:if>
        </div>
    </c:if>
    </p>
    
    <p class="card-text">${newsDesc.string}</p>
    <p class="card-text"><small class="text-muted"><fmt:formatDate value="${newsDate.date.time}" pattern="dd/MM/yyyy"/>&nbsp;<fmt:formatDate value="${newsDate.date.time}" pattern="HH:mm" var="dateTimeNews"/>
 <c:if test="${dateTimeNews != '00:00'}">${dateTimeNews}</c:if></small></p>
    <p class="card-text">
    <c:set var="parentPage" value="${jcr:getParentOfType(renderContext.mainResource.node, 'jnt:page')}" />
    <c:choose>
        <c:when test="${not empty parentPage}">
            <c:url value='${parentPage.url}' context="/" var="action"/>
        </c:when>
        <c:otherwise>
            <c:set var="action">javascript:history.back()</c:set>
        </c:otherwise>
    </c:choose>
    <a class="btn btn-primary" href="${action}" title='<fmt:message key="backToPreviousPage"/>'>Back</a>
      </p>
  </div>
</div>


