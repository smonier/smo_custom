<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>

<%--@elvariable id="currentUser" type="org.jahia.services.usermanager.JahiaUser"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<c:set var="site" value="${renderContext.site.title}"/>
<c:set var="redirect" value="${currentResource.moduleParams.redirect}"/>
<c:set var="failureRedirect" value="${currentResource.moduleParams.failureRedirect}"/>

<c:set var="loginMenuULClass" value="${currentNode.properties.loginMenuULClass.string}"/>
<c:if test="${empty loginMenuULClass}">
    <c:set var="loginMenuULClass" value="navbar-nav flex-row ml-md-auto d-none d-md-flex"/>
</c:if>
<c:choose>
    <c:when test="${renderContext.loggedIn}">
        <ul class="${loginMenuULClass} nav-flex-icons">
            <li class="nav-item dropdown">
                <a class="nav-item nav-link dropdown-toggle mr-md-2" href="#" id="${currentNode.identifier}"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        ${currentUser.username}
                </a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="${currentNode.identifier}">
                    <c:if test="${!renderContext.settings.distantPublicationServerMode and renderContext.mainResource.node.properties['j:originWS'].string ne 'live' and not jcr:isNodeType(renderContext.mainResource.node.resolveSite, 'jmix:remotelyPublished')}">
                        <c:if test="${! renderContext.liveMode}">
                            <a href="<c:url value='${url.live}'/>" class="dropdown-item">
                                <fmt:message key="bootstrap4mix_customBaseNavbar.label.live"/>
                            </a>
                        </c:if>
                        <c:if test="${! renderContext.previewMode && jcr:hasPermission(renderContext.mainResource.node, 'editModeAccess')}">
                            <a href="<c:url value='${url.preview}'/>" class="dropdown-item">
                                <fmt:message key="bootstrap4mix_customBaseNavbar.label.preview"/>
                            </a>
                        </c:if>
                        <c:if test="${! renderContext.editMode && jcr:hasPermission(renderContext.mainResource.node, 'editModeAccess')}">
                            <a href="<c:url value='${url.edit}'/>" class="dropdown-item">
                                <fmt:message key="magaMenuNavbar.label.edit"/>
                            </a>
                        </c:if>
                    </c:if>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="${url.logout}" class="logout"><fmt:message key="bootstrap4mix_customBaseNavbar.label.logout"/></a>
                </div>
            </li>
        </ul>
    </c:when>
    <c:otherwise>
        <template:include view="hidden.megaMenu.modal.login">
            <template:param name="redirect" value="${redirect}"/>
            <template:param name="failureRedirect" value="${failureRedirect}"/>
        </template:include>
    </c:otherwise>
</c:choose>
