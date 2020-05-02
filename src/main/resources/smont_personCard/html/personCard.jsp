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

<template:addResources type="css" resources="smoCustom.css"/>

<script language="JavaScript">
    $().ready(function(){
        $('[rel="tooltip"]').tooltip();

    });

    function rotateCard(btn){
        var $card = $(btn).closest('.rotatingCard-container');
        console.log($card);
        if($card.hasClass('hover')){
            $card.removeClass('hover');
        } else {
            $card.addClass('hover');
        }
    }
</script>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="fullName"/>
<jcr:nodeProperty node="${currentNode}" name="personBio" var="personBio"/>
<jcr:nodeProperty node="${currentNode}" name="personPortrait" var="personPortrait"/>
<jcr:nodeProperty node="${currentNode}" name="featuredImage" var="featuredImage"/>
<jcr:nodeProperty node="${currentNode}" name="personEmail" var="personEmail"/>
<jcr:nodeProperty node="${currentNode}" name="personTitle" var="personTitle"/>
<jcr:nodeProperty node="${currentNode}" name="personHeadline" var="personHeadline"/>
<jcr:nodeProperty node="${currentNode}" name="rotation" var="rotation"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:uuid" var="uuid"/>

<c:set var="facebook" value="${currentNode.properties.facebook.string}" />
<c:set var="linkedIn" value="${currentNode.properties.linkedIn.string}" />
<c:set var="twitter" value="${currentNode.properties.twitter.string}" />
<c:set var="googlePlus" value="${currentNode.properties.googlePlus.string}" />

<c:choose>
    <c:when test="${rotation eq 'Auto'}">
        <c:set var="rotationClass" value=""/>
    </c:when>
    <c:when test="${rotation eq 'Manual'}">
        <c:set var="rotationClass" value=" manual-flip"/>
    </c:when>
</c:choose>

<div class="rotatingCard-container ${rotationClass}">
    <div class="rotatingCard">
        <div class="front">
            <div>
                <img class="card-img-top" src="${featuredImage.node.url}" alt="${featuredImage.node.name}"/>
            </div>
            <div class="user">
                <img class="rounded-circle" src="${personPortrait.node.url}" alt="${fullName.string}"/>
            </div>

            <div class="rotatingCard-text">
                <div class="main">
                    <h3 class="name">${fullName.string}</h3>
                    <p class="profession">${personTitle.string}</p>
                    <p class="text-center"><a href="mailto:${personEmail.string}">${personEmail.string}</a></p>
                    <h4 class="name">${personHeadline.string}</h4>

                </div>
                <div class="footer">
                <c:if test="${rotation eq 'Manual'}">
                    <button class="btn btn-simple" rel="tooltip" title="Flip Card"  onclick="rotateCard(this)">
                        <a class="rotate-btn btn-floating btn-primary"><i class="fa fa-repeat"></i> Click here to rotate</a>
                    </button>
                </c:if>
                <c:if test="${rotation eq 'Auto'}">
                    <button class="btn btn-simple" rel="tooltip" title="Flip Card">
                        <a class="rotate-btn btn-floating btn-primary"><i class="fa fa-share"></i> Auto Rotation</a>
                    </button>
                </c:if>
                </div>
            </div>
        </div> <!-- end front panel -->
        <div class="back">
            <div class="header">
                <h5 class="motto">${fullName.string}</h5>
                <p class="profession">${personTitle.string}</p>

            </div>
            <div class="content">
                <div class="main">
                    <p class="text-center">${personBio.string}</p>
                    <div class="social-links text-center">
                        <c:if test="${! empty facebook}"><li class="list-inline-item"><a class="mx-1 btn-floating btn-primary" href="${facebook}"><i class="fa fa-facebook-f"></i></a></li></c:if>
                        <c:if test="${! empty twitter}"><li class="list-inline-item"><a class="mx-1 btn-floating btn-primary" href="${twitter}"><i class="fa fa-twitter"></i></a></li></c:if>
                        <c:if test="${! empty googlePlus}"><li class="list-inline-item"><a class="mx-1 btn-floating btn-primary" href="${googlePlus}"><i class="fa fa-google-plus"></i></a></li></c:if>
                        <c:if test="${! empty linkedIn}"><li class="list-inline-item"><a class="mx-1 btn-floating btn-primary" href="${linkedIn}"><i class="fa fa-linkedin"></i></a></li></c:if>
                    </div>
                </div>
            </div>
            <c:if test="${rotation eq 'Manual'}">
                <div class="footer">
                        <button class="btn btn-simple" rel="tooltip" title="Flip Card" onclick="rotateCard(this)">
                            <a class="rotate-btn btn-floating btn-primary"><i class="fa fa-undo"></i> Rotate Back</a>
                        </button>
                </div>
            </c:if>
        </div> <!-- end back panel -->
    </div> <!-- end card -->
</div>