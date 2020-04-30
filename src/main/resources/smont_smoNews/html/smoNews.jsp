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

<c:set var="galleryImgs" value="${currentNode.properties['smoGalleryImg']}"/>

<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="carouselId" value="carousel-${rand}"/>

<!-- Card Start -->
<div class="newsCard pt-2">
    <div class="row ">

        <div class="col-md-7 px-3">
            <div class="card-block px-6">
                <h4 class="card-title">${fn:escapeXml(newsTitle.string)} </h4>
                <p class="card-text">
                    ${functions:abbreviate(functions:removeHtmlTags(newsBody.string),400,450,'...')}
                </p>
                <br/>
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
                <a href="${linkUrl}" class="mt-auto btn btn-primary" target="${linkTarget}">${newsButtonText.string}</a>
                <br/>

            </div>

        </div>
        <!-- Carousel start -->
        <div class="col-md-5">
            <div id="${carouselId}" class="carousel slide" data-ride="carousel">

                <div class="carousel-inner">
                <c:forEach items="${galleryImgs}" var="galImage" varStatus="status">
                    <div class="carousel-item ${status.first?' active':''}">

                        <img class="card-img d-block" src="${galImage.node.url}" alt="${galImage.node.name}">

                    </div>
                </c:forEach>
                <ol class="carousel-indicators" style="justify-content: flex-end;">
                    <c:forEach items="${galleryImgs}" var="galImage" varStatus="status">
                        <li data-target="#${carouselId}" data-slide-to="${status.index}" class="${status.first?' active':''}"></li>
                    </c:forEach>

                </ol>

                    <a class="carousel-control-prev" href="#${carouselId}" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#${carouselId}" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
        </div>
        <!-- End of carousel -->
    </div>
    <div class="card-footer text-muted">
        Posted on <fmt:formatDate value="${newsDate.date.time}" pattern="dd/MM/yyyy"/>
    </div>
</div>
<!-- End of card -->
