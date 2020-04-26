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


<jcr:nodeProperty node="${currentNode}" name="image" var="newsImage"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="newsTitle"/>


<div class="card bg-dark text-white mb-2" style="width:100%">
    <c:if test="${not empty newsImage}">
        <jahia:addCacheDependency node="${newsImage.node}"/>
        <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
            <c:if test="${not empty newsImage}">
                <jahia:addCacheDependency node="${newsImage.node}"/>
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
                                     class="card-img"
                                     style="opacity: 0.5;"
                                     width="100%"
                                     alt="${fn:escapeXml(not empty newsTitle.string ? newsTitle.string : currentNode.name)}"
                                />

                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='${url.base}${currentNode.path}.html'/>">
                                    <img class="card-img" src="${imageUrl}" alt=""${newsTitle}" width="100%"/>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>
            </c:if>
    </c:if>
    <div class="card-img-overlay">
        <h3 class="card-title" style="color: #fff">${fn:escapeXml(newsTitle.string)}</h3>
        <p class="card-text">${functions:abbreviate(functions:removeHtmlTags(currentNode.properties.desc.string),400,450,'...')}</p>
    </div>
</div>


