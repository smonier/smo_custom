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
<template:addResources type="css" resources="allNewsPanel.css"/>
<template:addResources type="javascript" resources="filter.js"/>

<script src="https://unpkg.com/isotope-layout@3.0.3/dist/isotope.pkgd.js"></script>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['newsPanelDesc'].string}"/>

<script>
    const categoryArray =[];
    var graphQLQuery =  '{   jcr(workspace: LIVE) {     nodesByQuery(query: "select * from [smont:smoNews]", offset: 0) {       edges {         index         node {           displayName(language: "en")           description: property(language: "en", name: "desc") {             value           }           date: property(language: "en", name: "date") {             value           }           featured: property(language: "en", name: "featured") {             value           }           buttonText: property(language: "en", name: "buttonText") {             value           }           images: property(language: "en", name: "smoGalleryImg") {             image: refNodes {               path               name             }           }           categories: property(language: "en", name: "j:defaultCategory") {             refNodes {               path               name             }           }           tags: property(name: "j:tagList") {             values           }           interests: property(name: "wem:interests") {             values           }         }       }     }   } }';
    var xhr = new XMLHttpRequest();
    xhr.responseType = 'json';
    xhr.open("POST", "/modules/graphql");
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.setRequestHeader("Accept", "application/json");
    xhr.onload = function () {
        if (xhr.readyState == 4) {
            if(xhr.status == 200) {
                console.log('data returned:', xhr.response);
                var array = xhr.response
                generateCard(array.data.jcr.nodesByQuery.edges)
            }}
        }

    xhr.send(JSON.stringify({query: graphQLQuery}));

    function generateCard(newsArray) {
        var output = "";
        var modalOutput = "";
        var i;
        var newsTitle = "";
        var buttonText = "";
        var categories = "";
        var date = "";
        var description = "";
        var featuredNews = "";
        var imagePath = "";
        var interests = "";
        var tags = "";
        for (i = 0; i < newsArray.length; i++) {
            output = "";
            newsTitle = newsArray[i].node.displayName;

            if (newsArray[i].node.buttonText !== null) {
                buttonText = getObjectValue(newsArray[i].node.buttonText);
            }
            if (newsArray[i].node.categories !== null) {
                categories = getCategoryName(newsArray[i].node.categories);
            }
            if (newsArray[i].node.date !== null) {
                date = getObjectValue(newsArray[i].node.date);
            }
            if (newsArray[i].node.description !== null) {
                description = getObjectValue(newsArray[i].node.description);
            }
            if (newsArray[i].node.featured !== null) {
                featuredNews = getObjectValue(newsArray[i].node.featured);
            }
            if (newsArray[i].node.images !== null) {
                imagePath = '/files/live' + getImagePath(newsArray[i].node.images);
            }
            if (newsArray[i].node.interests !== null) {
                interests = getValuesArray(newsArray[i].node.interests);
            }
            if (newsArray[i].node.tags !== null) {
                var tags = getValuesArray(newsArray[i].node.tags);
            }


// Gallery Item //
            output += '<a href="#portfolioModal' + i + '" class="portfolio-link" data-toggle="modal">';
            output += '<div class="portfolio-hover">';
            output += ' <div class="portfolio-hover-content">';
            output += '<i class="fa fa-search-plus"></i>';
            output += '</div>';
            output += '</div>';
            output += '<img class="card-img d-block" src="' + imagePath + '"  alt="">';
            output += '</a>';
            output += '<div class="portfolio-caption">';
            output += '<h4>' + newsTitle + '</h4>';
            output += '<p class="text-muted">' + categories + '</p>';
            output += '</div>';


// Gallery Item Modal

            modalOutput += '<div class="portfolio-modal modal fade" id="portfolioModal' + i + '" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">';
            modalOutput += '<div class="modal-dialog">';
            modalOutput += '<div class="modal-content">';
            modalOutput += ' <div class="close-modal" data-dismiss="modal">';
            modalOutput += '<div class="lr">';
            modalOutput += '<div class="rl">';
            modalOutput += '</div>';
            modalOutput += '</div>';
            modalOutput += '</div>';
            modalOutput += '<div class="container">';
            modalOutput += '<div class="row">';
            modalOutput += '<div class="col-lg-12 col-lg-offset-2">';
            modalOutput += '<div class="modal-body">';
            modalOutput += '<h3>' + newsTitle + '</h3>';
            modalOutput += '<img class="img-responsive img-centered" src="' + imagePath + '" alt="">';
            modalOutput += '<p class="item-intro text-muted">' + description + '</p>';
            modalOutput += '<ul class="list-inline">';
            modalOutput += '</ul>';
            modalOutput += '</div>';
            modalOutput += '</div>';
            modalOutput += '</div>';
            modalOutput += '</div>';
            modalOutput += '</div>';
            modalOutput += '</div>';
            modalOutput += '</div>';

            var newNode = document.createElement("DIV");
            newNode.classList.add("col-md-4");
            newNode.classList.add("col-sm-6");
            newNode.classList.add("portfolio-item");
            if (newsArray[i].node.categories !== null) {
                var catArr = newsArray[i].node.categories.refNodes;
                for(var l = 0; l < catArr.length; l++) {
                    newNode.classList.add(catArr[l].name);
                }
            }
            newNode.innerHTML = output;
            document.getElementById("galleryItem").appendChild(newNode);

        }
        var uniqueCategories = [];
        $.each(categoryArray, function (i, el) {
            if ($.inArray(el, uniqueCategories) === -1) uniqueCategories.push(el);
        });

        for (var j = 0; j < uniqueCategories.length; j++) {
            var catNode = document.createElement("li");
            var subCatNode = document.createElement("a");
            var textnode = document.createTextNode(uniqueCategories[j]);
            subCatNode.classList.add("btn");
            subCatNode.classList.add("btn-primary-outline");

            subCatNode.setAttribute('href', '#');
            subCatNode.setAttribute('data-filter', '.' + uniqueCategories[j]);
            subCatNode.appendChild(textnode);
            catNode.appendChild(subCatNode);
            document.getElementById("filteringNav").appendChild(catNode);
        }

        var modalBlock = document.getElementById("portfolioModals");
        modalBlock.innerHTML = modalOutput;
    }


    function getObjectValue (objProperties) {
        return(objProperties.value);
    }
    function getImagePath (objArray) {
        var out = "";
        var i;
        for(i = 0; i < objArray.image.length; i++) {
            out = objArray.image[i].path ;
        }
        return(out);
    }
    function getImageName (objArray) {
        var out = "";
        var i;
        for(i = 0; i < objArray.image.length; i++) {
            out = objArray.image[i].name ;
        }
        return(out);
    }

    function getValuesArray (objArray) {
        var out = "";
        var i;
        for(i = 0; i < objArray.values.length; i++) {
            out += objArray.values[i] + ' ';
        }
        return(out);
    }

    function getCategoryPath (objArray) {
        var out = "";
        var i;
        for(i = 0; i < objArray.refNodes.length; i++) {
            out += objArray.refNodes[i].path + ' ';
        }
        return(out);
    }
    function getCategoryName (objArray) {
        var out = "";
        var i;
        for(i = 0; i < objArray.refNodes.length; i++) {
            out += objArray.refNodes[i].name + ' ';
            categoryArray.push(objArray.refNodes[i].name);
        }
        return(out);
    }
</script>


<section id="portfolio" class="">
    <div class="gallary animate-grid">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">${title}</h2>
                    <h3 class="section-subheading text-muted">${description}</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 w-100">
                    <div class="categories">
                        <ul>
                            <li>
                                <ol id="filteringNav">
                                    <li><a href="#" data-filter="*" class="btn btn-primary-outine active">All</a></li>
                                </ol>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row gallary-thumbs" id="galleryItem">
            </div>
        </div>
</section>


<!-- Portfolio Modals -->
<!-- The script bellow will open a page for every single portfolio item which will contain detailed information about that item! -->

<!-- Portfolio Modal 1 -->
<div id="portfolioModals"></div>
