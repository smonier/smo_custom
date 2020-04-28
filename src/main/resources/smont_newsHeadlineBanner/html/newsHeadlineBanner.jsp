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

<template:addResources type="css" resources="newsHeadlineBanner.css"/>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="bannerText" value="${currentNode.properties['bannerText'].string}"/>

<%-- get the child items --%>
<c:set var="newsList" value="${jcr:getChildrenOfType(currentNode, 'smont:smoNews')}"/>

<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="carouselId" value="carousel-${rand}"/>

<!--Container-->
<div class="container">
    <div class="row mb-2">
        <div class="col-12 text-center pt-3">
            <h1>${title}</h1>
            <p>${bannerText}</p>
        </div>
    </div>

    <!--Start code-->
    <div class="row">
        <div class="col-12 pb-5">
            <!--SECTION START-->
            <section class="row">
                <!--Start slider news-->
                <div class="col-12 col-md-6 pb-0 pb-md-3 pt-2 pr-md-1">
                    <div id="${carouselId}" class="carousel slide carousel" data-ride="carousel">
                        <!--dots navigate-->

                        <ol class="carousel-indicators top-indicator">
                            <c:set var="featuredIndex" value="0" scope="page"/>
                            <c:forEach items="${newsList}" var="news" varStatus="status">
                                <c:if test="${news.properties['featured'].boolean}">
                                    <li data-target="#${carouselId}" data-slide-to="${featuredIndex}" class="rounded-circle ${status.first?' active':''}"></li>
                                    <c:set var="featuredIndex" value="${featuredIndex + 1}" scope="page"/>
                                </c:if>
                            </c:forEach>
                        </ol>

                        <!--carousel inner-->
                        <div class="carousel-inner">
                            <!--Item slider-->
                        <c:forEach items="${newsList}" var="news" varStatus="status">
                            <c:if test="${news.properties['featured'].boolean}">
                            <div class="carousel-item ${status.first?' active':''}">
                                <template:module node="${news}"  view="featuredCarousel" editable="true"/>
                            </div>
                            </c:if>
                        </c:forEach>
                        <!--end carousel inner-->
                        </div>

                        <!--navigation-->
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
                <!--End slider news-->
                <!--Start box news-->
                <div class="col-12 col-md-6 pt-2 pl-md-1 mb-3 mb-lg-4">
                    <div class="row">
                        <!--news box-->
                        <c:set var="boxIndex" value="0" scope="page"/>

                        <c:forEach items="${newsList}" var="news" varStatus="status">
                            <c:if test="${not news.properties['featured'].boolean}">
                                <c:choose>
                                <c:when test="${boxIndex == 0}"><c:set var="boxClass" value="col-6 pb-1 pt-0 pr-1"/></c:when>
                                <c:when test="${boxIndex == 1}"><c:set var="boxClass" value="col-6 pb-1 pl-1 pt-0"/></c:when>
                                <c:when test="${boxIndex == 2}"><c:set var="boxClass" value="col-6 pb-1 pr-1 pt-1"/></c:when>
                                <c:when test="${boxIndex == 3}"><c:set var="boxClass" value="col-6 pb-1 pl-1 pt-1"/></c:when>
                                </c:choose>

                                    <div class="${boxClass}">
                                        <template:module node="${news}"  view="headlineBanner" editable="true"/>
                                </div>
                                <c:set var="boxIndex" value="${boxIndex + 1}" scope="page"/>
                            </c:if>
                        </c:forEach>
                        <!--news box-->

                        <!--end news box-->
                    </div>
                </div>
                <!--End box news-->
            </section>
            <!--END SECTION-->
        </div>
    </div>
    <!--end code-->


</div>



<c:if test="${renderContext.editMode}">
    <%--
    As only one child type is defined no need to restrict
    if a new child type is added restriction has to be done
    using 'nodeTypes' attribute
    --%>
    <template:module path="*" />
</c:if>