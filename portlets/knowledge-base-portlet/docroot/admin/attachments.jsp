<%--
/**
 * Copyright (c) 2000-2012 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/admin/init.jsp" %>

<%
KBArticle kbArticle = (KBArticle)request.getAttribute(WebKeys.KNOWLEDGE_BASE_KB_ARTICLE);

long resourcePrimKey = BeanParamUtil.getLong(kbArticle, request, "resourcePrimKey");

List<FileEntry> attachments = new ArrayList<FileEntry>();

if (kbArticle != null) {
	attachments = kbArticle.getAttachmentsFiles();
}
%>

<div class="kb-attachments">

	<%
	for (FileEntry attachment : attachments) {
	%>

		<div>
			<liferay-portlet:resourceURL id="attachment" var="clipURL">
				<portlet:param name="resourcePrimKey" value="<%= String.valueOf(resourcePrimKey) %>" />
			</liferay-portlet:resourceURL>

			<liferay-ui:icon
				image="clip"
				label="<%= true %>"
				message='<%= attachment.getTitle() + " (" + TextFormatter.formatKB(attachment.getSize(), locale) + "k)" %>'
				method="get"
				url="<%= clipURL %>"
			/>
		</div>

	<%
	}
	%>

	<liferay-portlet:renderURL var="selectAttachmentsURL" windowState="<%= LiferayWindowState.POP_UP.toString() %>">
		<portlet:param name="mvcPath" value='<%= templatePath + "select_attachments.jsp" %>' />
		<portlet:param name="resourcePrimKey" value="<%= String.valueOf(resourcePrimKey) %>" />
		<portlet:param name="status" value="<%= String.valueOf(WorkflowConstants.STATUS_ANY) %>" />
	</liferay-portlet:renderURL>

	<liferay-portlet:actionURL name="updateAttachments" var="updateAttachmentsURL">
		<portlet:param name="redirect" value="<%= selectAttachmentsURL %>" />
		<portlet:param name="resourcePrimKey" value="<%= String.valueOf(resourcePrimKey) %>" />
	</liferay-portlet:actionURL>

	<%
	String taglibOnClick = "var selectAttachmentsWindow = window.open('" + updateAttachmentsURL + "&" + renderResponse.getNamespace() + "dirName=' + document." + renderResponse.getNamespace() + "fm." + renderResponse.getNamespace() + "dirName.value, 'selectAttachments', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no,width=680'); void(''); selectAttachmentsWindow.focus();";
	%>

	<div class="kb-edit-link">
		<aui:a href="javascript:;" onClick="<%= taglibOnClick %>"><liferay-ui:message key='<%= (!attachments.isEmpty()) ? "attachments" : "add-attachments" %>' /> &raquo;</aui:a>
	</div>
</div>