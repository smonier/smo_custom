<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="user" uri="http://www.jahia.org/tags/user" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%--@elvariable id="currentUser" type="org.jahia.services.usermanager.JahiaUser"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="site" value="${renderContext.site.title}"/>
<c:set var="redirect" value="${currentResource.moduleParams.redirect}"/>
<c:set var="failureRedirect" value="${currentResource.moduleParams.failureRedirect}"/>

<c:set var="siteNode" value="${renderContext.site}"/>
<c:choose>
    <c:when test="${jcr:isNodeType(siteNode, 'bootstrap4mix:siteBrand')}">
        <c:set var="brandImage" value="${siteNode.properties.brandImage.node}"/>
        <c:set var="brandText" value="${siteNode.properties.brandText.string}"/>
    </c:when>
    <c:when test="${jcr:isNodeType(currentNode, 'bootstrap4mix:brand')}">
        <c:set var="brandImage" value="${currentNode.properties.brandImage.node}"/>
        <c:set var="brandText" value="${currentNode.properties.brandText.string}"/>
    </c:when>
</c:choose>

<c:set var="showModal" value="${not empty param['loginError'] ? 'true' : 'false'}"/>
<utility:logger level="info" value="loginError : ${param['loginError']}"/>

<%--<c:set var="loginMenuULClass" value="${currentNode.properties.loginMenuULClass.string}"/>--%>
<%--<c:if test="${empty loginMenuULClass}">--%>
<%--    <c:set var="loginMenuULClass" value="navbar-nav flex-row ml-md-auto d-none d-md-flex"/>--%>
<%--</c:if>--%>

<%--<ul class="${loginMenuULClass}">--%>
<%--    <li class="nav-item">--%>
        <button type="button" class="btn btn-primary btn-nest my-2 my-sm-0" data-toggle="modal" data-target="#loginModal">
            <fmt:message key="login-form.label.login"/>
        </button>
<%--    </li>--%>
<%--</ul>--%>

<%--<form class="form-inline">--%>
<%--    <button class="btn btn-nest my-2 my-sm-0" type="submit"> <fmt:message key="login-form.label.login"/></button>--%>
<%--</form>--%>

<div class="modal modal-nest fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true" <c:if test="${showModal}">data-show='true'</c:if>>
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="loginModal-content">


            <div class="modal-body justify-content-center">
               <div class="container h-100">
                    <div class="d-flex justify-content-center h-100">
                        <div class="user_card">
                            <div class="d-flex justify-content-center">
                                <div class="brand_logo_container">
                                    <img src="${brandImage.url}" class="brand_logo" alt="Logo">
                                </div>
                            </div>
                            <div class="d-flex justify-content-center form_container">
                                <form  method="post" name="loginForm" action="${url.login}">
                                    <input type="hidden" name="site" value="${site}">
                                    <input type="hidden" name="redirect" value="${redirect}">
                                    <input type="hidden" name="failureRedirect" value="${failureRedirect}">
                                    <div class="input-group mb-3">
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fa fa-user-circle-o"></i></span>
                                        </div>
                                        <input type="text" class="form-control input_user" name="username" id="username" placeholder="<fmt:message key="login-form.placeholder.username"/>">

                                    </div>
                                    <div class="input-group mb-2">
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fa fa-key"></i></span>
                                        </div>
                                        <input type="password" class="form-control input_pass" name="password" id="password" placeholder="<fmt:message key="login-form.placeholder.password"/>">

                                    </div>
                                    <div class="form-group">
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input" id="customControlInline">
                                            <label class="custom-control-label" for="customControlInline">Remember me</label>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-center mt-3 login_container">
                                        <button type="submit" class="btn btn-primary text-uppercase"><fmt:message key="login-form.btn.login"/></button>                                    </div>
                                </form>
                            </div>

                            <div class="mt-4">
                                <div class="d-flex justify-content-center links">
                                    Don't have an account? <a href="#" class="ml-2">Sign Up</a>
                                </div>
                                <div class="d-flex justify-content-center links">
                                    <a href="#">Forgot your password?</a>
                                </div>
                            </div>
                            <c:if test="${not empty param['loginError']}">
                                <div class="alert btn-danger mt-4 mb-5 text-center">
                                    <c:choose>
                                        <c:when test="${param['loginError'] == 'account_locked'}">
                                            <fmt:message key="login-form.message.accountLocked" />
                                        </c:when>
                                        <c:when test="${param['loginError'] == 'logged_in_users_limit_reached'}">
                                            <fmt:message key="login-form.message.userLimitReached"/>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:message key="login-form.message.incorrectLogin" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <c:remove var="param['loginError']"/>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>



        </div>
    </div>
</div>

<c:if test="${showModal == 'true'}">
    <script type="text/javascript">
        $(function(){
            $('#loginModal').modal();
        } )
    </script>
</c:if>