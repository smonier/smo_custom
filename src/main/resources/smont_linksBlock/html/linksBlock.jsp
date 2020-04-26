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

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="blockTitle"/>

<jcr:nodeProperty node="${currentNode}" name="buttonText" var="newsButtonText"/>
<c:set var="links" value="${jcr:getChildrenOfType(currentNode, 'smont:blockInternalLink,smont:blockExternalLink')}"/>


<!-- Card Start -->
<div class="card p-3 mb-2 mt-2" style="width:100%">

                <h4 class="card-title">${fn:escapeXml(blockTitle.string)} </h4>
                <p class="card-text">

                    <c:forEach items="${links}" var="link" varStatus="item">
                            <template:module node="${link}"  editable="true"/>
                    </c:forEach>
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
                <p class="card-text text-right">
                <a href="${linkUrl}" class="mt-auto btn btn-outline-primary btn-sm" target="${linkTarget}">${newsButtonText.string}</a>
                </p>
</div>
<!-- End of card -->
<c:if test="${renderContext.editMode}">
    <%--
    As only one child type is defined no need to restrict
    if a new child type is added restriction has to be done
    using 'nodeTypes' attribute
    --%>
    <template:module path="*" />
</c:if>