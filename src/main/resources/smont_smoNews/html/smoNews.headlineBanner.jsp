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
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="smoNews.css"/>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="newsTitle"/>
<jcr:nodeProperty node="${currentNode}" name="desc" var="newsBody"/>
<jcr:nodeProperty node="${currentNode}" name="date" var="newsDate"/>
<jcr:nodeProperty node="${currentNode}" name="buttonText" var="newsButtonText"/>
<jcr:nodeProperty node="${currentNode}" name="featured" var="featured"/>
<jcr:nodeProperty node="${currentNode}" var="newsCategories" name="j:defaultCategory"/>

<c:set var="galleryImgs" value="${currentNode.properties['smoGalleryImg']}"/>

<c:set var="linkType" value="${currentNode.properties.linkType.string}" />
<c:set var="linkTarget" value="${currentNode.properties.linkTarget.string}" />

<c:choose>
    <c:when test="${linkType eq 'internalLink'}">
        <c:set var="internalLinkNode" value="${currentNode.properties.internalLink.node}"/>
        <c:choose>
            <c:when test="${! empty internalLinkNode}">
                <c:url var="linkUrl" value="${internalLinkNode.url}"/>
            </c:when>
        </c:choose>
    </c:when>
    <c:when test="${linkType eq 'externalLink'}">
        <c:url var="linkUrl" value="${currentNode.properties.externalLink.string}"/>
    </c:when>
    <c:when test="${linkType eq 'self'}">
        <c:url var="linkUrl" value="${currentNode.url}"/>
    </c:when>
</c:choose>



<div class="card border-0 rounded-0 text-white overflow zoom">
    <div class="position-relative">
        <!--thumbnail img-->
        <div class="ratio_right-cover-2 image-wrapper">
            <c:forEach items="${galleryImgs}" var="galImage" varStatus="status"  begin="0" end="0">
                <a href="${linkUrl}">
                    <img class="img-fluid" src="${galImage.node.url}" alt="${galImage.node.name}">
                </a>
            </c:forEach>

        </div>
        <div class="position-absolute p-2 p-lg-3 b-0 w-100 bg-shadow">
            <!-- category -->
            <c:if test="${!empty newsCategories }">
                    <jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>
                    <c:if test="${cat != null}">
                        <c:forEach items="${cat}" var="category">
                            <a class="p-1 badge badge-primary rounded-0" href="${linkUrl}">${category.node.displayableName}</a>
                        </c:forEach>
                    </c:if>
            </c:if>
            <!--title-->
            <a href="${linkUrl}">
                <h2 class="h5 text-white my-1">${newsTitle}</h2>
            </a>
        </div>
    </div>
</div>