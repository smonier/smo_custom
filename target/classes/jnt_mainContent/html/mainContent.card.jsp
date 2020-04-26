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

<jcr:nodeProperty node="${currentNode}" name="image" var="image"/>


    <div class="card">
        <div class="row ">
            <c:choose>
                <c:when test="${currentNode.properties.align.string == 'right'}">
                        <div class="col-sm-7">
                            <div class="card-block">
                                <h4 class="card-title"><jcr:nodeProperty node="${currentNode}" name="jcr:title"/></h4>
                                <p class="card-text">
                                    ${currentNode.properties.body.string}
                                </p>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <img class="card-img" src="${image.node.url}" alt="${image.node.url}"/>
                        </div>
                </c:when>
                <c:otherwise>
                    <div class="col-sm-5">
                        <img class="card-img" src="${image.node.url}" alt="${image.node.url}"/>
                    </div>
                    <div class="col-sm-7">
                        <div class="card-block">
                            <h4 class="card-title"><jcr:nodeProperty node="${currentNode}" name="jcr:title"/></h4>
                            <p class="card-text">
                                    ${currentNode.properties.body.string}
                            </p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>


