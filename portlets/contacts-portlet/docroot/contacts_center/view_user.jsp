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

<%@ include file="/init.jsp" %>

<%
String backURL = ParamUtil.getString(request, "backURL");

long userId = ParamUtil.getLong(request, "userId");

User user2 = null;

if (userId > 0) {
	user2 = UserLocalServiceUtil.getUser(userId);
}
else {
	user2 = (User)request.getAttribute(WebKeys.CONTACTS_USER);
}

user2 = user2.toEscapedModel();

boolean myProfile = false;
String editableClass = StringPool.BLANK;

if (user2.getUserId() == themeDisplay.getUser().getUserId()) {
	editableClass = "quick-edit-field";
	myProfile = true;
}

Contact contact2 = user2.getContact();

List<Phone> phones = null;
List<EmailAddress> emailAddresses = null;
List<Address> addresses = null;
List<Website> websites = null;

phones = PhoneServiceUtil.getPhones(Contact.class.getName(), contact2.getContactId());
emailAddresses = EmailAddressServiceUtil.getEmailAddresses(Contact.class.getName(), contact2.getContactId());
addresses = AddressServiceUtil.getAddresses(Contact.class.getName(), contact2.getContactId());
websites = WebsiteServiceUtil.getWebsites(Contact.class.getName(), contact2.getContactId());

String aimSn = contact2.getAimSn();
String icqSn = contact2.getIcqSn();
String jabberSn = contact2.getJabberSn();
String msnSn = contact2.getMsnSn();
String skypeSn = contact2.getSkypeSn();
String ymSn = contact2.getYmSn();

boolean hasInstantMessenger = false;
if (Validator.isNotNull(aimSn) || Validator.isNotNull(icqSn) || Validator.isNotNull(jabberSn) || Validator.isNotNull(msnSn) || Validator.isNotNull(skypeSn) || Validator.isNotNull(ymSn)) {
	hasInstantMessenger = true;
}

String facebookSn = contact2.getFacebookSn();
String mySpaceSn = contact2.getMySpaceSn();
String twitterSn = contact2.getTwitterSn();

boolean hasSocialNetwork = false;
if (Validator.isNotNull(facebookSn) || Validator.isNotNull(mySpaceSn) || Validator.isNotNull(twitterSn)) {
	hasSocialNetwork = true;
}

String smsSn = contact2.getSmsSn();

request.setAttribute("view_user.jsp-user", user2);
request.setAttribute("view_user.jsp-myProfile", myProfile);
request.setAttribute("view_user.jsp-editableClass", editableClass);

request.setAttribute("view_user.jsp-addresses", addresses);
request.setAttribute("view_user.jsp-phones", phones);
request.setAttribute("view_user.jsp-emailAddresses", emailAddresses);
request.setAttribute("view_user.jsp-websites", websites);

request.setAttribute("view_user.jsp-aimSn", aimSn);
request.setAttribute("view_user.jsp-icqSn", icqSn);
request.setAttribute("view_user.jsp-jabberSn", jabberSn);
request.setAttribute("view_user.jsp-msnSn", msnSn);
request.setAttribute("view_user.jsp-skypeSn", skypeSn);
request.setAttribute("view_user.jsp-ymSn", ymSn);
request.setAttribute("view_user.jsp-hasInstantMessenger", hasInstantMessenger);

request.setAttribute("view_user.jsp-facebookSn", facebookSn);
request.setAttribute("view_user.jsp-mySpaceSn", mySpaceSn);
request.setAttribute("view_user.jsp-twitterSn", twitterSn);
request.setAttribute("view_user.jsp-hasSocialNetwork", hasSocialNetwork);

request.setAttribute("view_user.jsp-smsSn", smsSn);
%>

<div id="<portlet:namespace/>saveMessages"></div>

<c:if test="<%= user2 != null %>">
	<div class="contacts-profile" id="<portlet:namespace />ContactsWrapper">
		<c:if test="<%= (displayStyle == ContactsConstants.DISPLAY_STYLE_BASIC) || (displayStyle ==ContactsConstants.DISPLAY_STYLE_FULL) %>">
			<aui:layout cssClass="social-relations">

				<%
				boolean connection = SocialRelationLocalServiceUtil.hasRelation(themeDisplay.getUserId(), user2.getUserId(), SocialRelationConstants.TYPE_BI_CONNECTION);
				boolean follower = SocialRelationLocalServiceUtil.hasRelation(user2.getUserId(), themeDisplay.getUserId(), SocialRelationConstants.TYPE_UNI_FOLLOWER);
				boolean following = SocialRelationLocalServiceUtil.hasRelation(themeDisplay.getUserId(), user2.getUserId(), SocialRelationConstants.TYPE_UNI_FOLLOWER);
				%>

				<c:if test="<%= connection || follower || following %>">
					<div class="lfr-asset-metadata">
						<c:if test="<%= connection %>">
							<span class="lfr-asset-icon lfr-asset-connection<%= (following || follower) ? StringPool.BLANK : " last" %>">
								<liferay-ui:message key="connection" />
							</span>
						</c:if>

						<c:if test="<%= following %>">
							<span class="lfr-asset-icon lfr-asset-following<%= follower ? StringPool.BLANK : " last" %>">
								<liferay-ui:message key="following" />
							</span>
						</c:if>

						<c:if test="<%= follower %>">
							<span class="lfr-asset-icon lfr-asset-follower last">
								<liferay-ui:message key="follower" />
							</span>
						</c:if>
					</div>
				</c:if>

				<aui:layout cssClass="contacts-action">
					<c:choose>
						<c:when test="<%= portletName.equals(PortletKeys.CONTACTS_CENTER) %>">

							<%
							boolean blocked = false;

							if (SocialRelationLocalServiceUtil.hasRelation(user2.getUserId(), themeDisplay.getUserId(), SocialRelationConstants.TYPE_UNI_ENEMY)) {
								blocked = true;
							}
							else if (SocialRelationLocalServiceUtil.hasRelation(themeDisplay.getUserId(), user2.getUserId(), SocialRelationConstants.TYPE_UNI_ENEMY)) {
								blocked = true;
							}
							%>

							<c:choose>
								<c:when test="<%= !blocked && SocialRequestLocalServiceUtil.hasRequest(themeDisplay.getUserId(), User.class.getName(), themeDisplay.getUserId(), SocialRelationConstants.TYPE_BI_CONNECTION, user2.getUserId(), SocialRequestConstants.STATUS_PENDING) %>">
									<liferay-ui:icon
										cssClass="disabled"
										image="../social/coworker"
										label="<%= true %>"
										message="connection-requested"
									/>
								</c:when>
								<c:when test="<%= !blocked && SocialRelationLocalServiceUtil.hasRelation(themeDisplay.getUserId(), user2.getUserId(), SocialRelationConstants.TYPE_BI_CONNECTION) %>">
									<liferay-ui:icon
										cssClass="connected"
										image="../social/coworker"
										label="<%= true %>"
										message="connected"
									/>
								</c:when>
							</c:choose>

							<c:if test="<%= !blocked && SocialRelationLocalServiceUtil.hasRelation(themeDisplay.getUserId(), user2.getUserId(), SocialRelationConstants.TYPE_UNI_FOLLOWER) %>">
								<liferay-ui:icon
									cssClass="following"
									image="../social/following"
									label="<%= true %>"
									message="following"
								/>
							</c:if>

							<c:if test="<%= SocialRelationLocalServiceUtil.hasRelation(themeDisplay.getUserId(), user2.getUserId(), SocialRelationConstants.TYPE_UNI_ENEMY) %>">
								<liferay-ui:icon
									cssClass="block"
									image="../social/block"
									label="<%= true %>"
									message="block"
								/>
							</c:if>
						</c:when>
						<c:otherwise>
							<liferay-util:include page="/contacts_center/user_toolbar.jsp" servletContext="<%= application %>" />
						</c:otherwise>
					</c:choose>
				</aui:layout>
			</aui:layout>

			<div class="lfr-contact-grid-item">
				<c:if test="<%= showIcon %>">
					<div class="lfr-contact-thumb">
						<a href="<%= user2.getDisplayURL(themeDisplay) %>"><img alt="<%= HtmlUtil.escape(user2.getFullName()) %>" src="<%= user2.getPortraitURL(themeDisplay) %>" /></a>
					</div>
				</c:if>

				<div class="<%= showIcon ? StringPool.BLANK : "no-icon" %> lfr-contact-info">
					<div class="lfr-contact-name">
						<a href="<%= user2.getDisplayURL(themeDisplay) %>"><%= HtmlUtil.escape(user2.getFullName()) %></a>
					</div>

					<c:choose>
						<c:when test="<%= myProfile %>">
							<div class="<%= editableClass %> one-line" data-fieldName="jobTitle">
								<%= Validator.isNotNull(user2.getJobTitle()) ? HtmlUtil.escape(user2.getJobTitle()) : LanguageUtil.get(pageContext, "add-your-job-title-here") %>
							</div>
						</c:when>
						<c:otherwise>
								<%= HtmlUtil.escape(user2.getJobTitle()) %>
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="<%= myProfile %>">
							<div class="<%= editableClass %> one-line" data-fieldName="emailAddress">
								<%= Validator.isNotNull(user2.getEmailAddress()) ? HtmlUtil.escape(user2.getEmailAddress()) : LanguageUtil.get(pageContext, "add-your-email-here") %>
							</div>
						</c:when>
						<c:otherwise>
								<%= HtmlUtil.escape(user2.getEmailAddress()) %>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="clear"><!-- --></div>
			</div>
		</c:if>

		<c:if test="<%= ((displayStyle == ContactsConstants.DISPLAY_STYLE_DETAIL) || (displayStyle ==ContactsConstants.DISPLAY_STYLE_FULL)) && UserPermissionUtil.contains(permissionChecker, user2.getUserId(), ActionKeys.VIEW) %>">
			<aui:layout cssClass="user-information">

				<c:if test="<%= showUsersInformation %>">
					<aui:column cssClass="user-information-column-1" columnWidth="<%= showSites ? 80 : 100 %>">
						<div class="lfr-user-info-container">
							<liferay-util:include page="/contacts_center/view_user_information.jsp" servletContext="<%= application %>" />
						</div>

						<%
						Map<String, String> extensions = ContactsExtensionsUtil.getExtensions();

						Set<String> servletContextNames = extensions.keySet();

						for (String servletContextName : servletContextNames) {
							String extensionPath = extensions.get(servletContextName);

							ServletContext extensionServletContext = ServletContextPool.get(servletContextName);

							String title = extensionPath.substring(extensionPath.lastIndexOf(StringPool.SLASH) + 1, extensionPath.lastIndexOf(StringPool.PERIOD));

							title = title.replace(CharPool.UNDERLINE, CharPool.DASH);

							String cssClass = "lfr-" + title + "-container";
						%>

							<div class="section field-container">
								<div class="field-actions-toolbar yui3-widget-hd">
									<div class="user-information-title">
										<liferay-ui:message key="<%= title %>" />:
									</div>
								</div>

								<div class="field-values">
									<div class="property-list">
										<div class="<%= cssClass %>">
											<liferay-util:include page="<%= extensionPath %>" servletContext="<%= extensionServletContext %>" />
										</div>
									</div>
								</div>
							</div>

						<%
						}
						%>

					</aui:column>
				</c:if>

				<c:if test="<%= showSites || showTags %>">
					<aui:column cssClass="user-information-column-2" columnWidth="<%= showUsersInformation ? 20 : 100 %>">
						<c:if test="<%= showSites %>">

							<%
							LinkedHashMap groupParams = new LinkedHashMap();

							groupParams.put("site", Boolean.TRUE);

							Group group = themeDisplay.getScopeGroup();

							if (group.isUser()) {
								groupParams.put("usersGroups", new Long(group.getClassPK()));
							}
							else {
								groupParams.put("usersGroups", new Long(themeDisplay.getUserId()));
							}

							groupParams.put("active", Boolean.TRUE);

							if (group.isUser() && (themeDisplay.getUserId() != group.getClassPK())) {
								List<Integer> types = new ArrayList<Integer>();

								types.add(GroupConstants.TYPE_SITE_OPEN);
								types.add(GroupConstants.TYPE_SITE_RESTRICTED);

								groupParams.put("types", types);
							}

							List<Group> results = GroupLocalServiceUtil.search(company.getCompanyId(), null, null, groupParams, QueryUtil.ALL_POS, QueryUtil.ALL_POS);
							%>

							<div class="user-sites-title">
								<liferay-ui:message key="sites" />
							</div>

							<div class="user-sites">
								<c:choose>
									<c:when test="<%= !results.isEmpty() %>">

										<%
										for (Group currGroup : results) {
											PortletURL groupURL = renderResponse.createActionURL();

											groupURL.setWindowState(WindowState.NORMAL);

											groupURL.setParameter("struts_action", "/sites_admin/page");
											groupURL.setParameter("redirect", currentURL);
											groupURL.setParameter("groupId", String.valueOf(group.getGroupId()));
											groupURL.setParameter("privateLayout", Boolean.FALSE.toString());
										%>

											<a href="<%= groupURL %>"><%= currGroup.getDescriptiveName(locale) %></a>&nbsp;

										<%
										}
										%>

									</c:when>
									<c:otherwise>
										<div class="empty">
											<liferay-ui:message arguments="<%= PortalUtil.getUserName((group.isUser() ? group.getClassPK() : themeDisplay.getUserId()), group.getDescriptiveName(locale)) %>" key="x-does-not-belong-to-any-sites" />
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</c:if>

						<c:if test="<%= showTags %>">
							<div class="user-tags-title">
								<liferay-ui:message key="tags" />
							</div>

							<ul class="user-tags">

								<%
								StringBuilder sb = new StringBuilder();

								List<AssetTag> tags = AssetTagLocalServiceUtil.getTags(User.class.getName(), user2.getUserId());

								for (AssetTag tag : tags) {
									PortletURL searchURL = ((LiferayPortletResponse)renderResponse).createRenderURL("3");

									searchURL.setWindowState(WindowState.MAXIMIZED);

									searchURL.setParameter("groupId", "0");
									searchURL.setParameter("keywords", tag.getName());
									searchURL.setParameter("struts_action", "/search/search");

									sb.append("<li><a href=\"");
									sb.append(searchURL);
									sb.append("\">");
									sb.append(tag.getName());
									sb.append("</a></li>");
								}
								%>

								<%= sb.toString() %>
							</ul>
						</c:if>

						<div class="profile-actions-title">
							<liferay-ui:message key="complete-your-profile" />
						</div>

						<div class="profile-actions">
							<c:if test="<%= myProfile %>">
								<div class="field-actions-toolbar">
									<ul class="settings-actions">
										<c:if test="<%= Validator.isNull(user2.getComments()) %>">
											<li class="action-field aui-component aui-settings-field lfr-token">
												<div class="aui-settings-field-content">
													<span class="settings-label" id=""><liferay-ui:message key="add-an-extract" /></span>
												</div>
											</li>
										</c:if>

										<c:if test="<%= phones == null || phones.isEmpty() %>">
											<li class="action-field aui-component aui-settings-field lfr-token">
												<div class="aui-settings-field-content">
													<span class="settings-label" id=""><liferay-ui:message key="add-a-phone" /></span>
												</div>
											</li>
										</c:if>

										<c:if test="<%= emailAddresses == null || emailAddresses.isEmpty() %>">
											<li class="action-field aui-component aui-settings-field lfr-token">
												<div class="aui-settings-field-content">
													<span class="settings-label"><liferay-ui:message key="add-an-email-address" /></span>
												</div>
											</li>
										</c:if>

										<c:if test="<%= !hasInstantMessenger %>">
											<li class="action-field aui-component aui-settings-field lfr-token">
												<div class="aui-settings-field-content">
													<span class="settings-label" id=""><liferay-ui:message key="add-your-instant-messenger" /></span>
												</div>
											</li>
										</c:if>

										<c:if test="<%= addresses == null || addresses.isEmpty() %>">
											<li class="action-field aui-component aui-settings-field lfr-token">
												<div class="aui-settings-field-content">
													<span class="settings-label"><liferay-ui:message key="add-an-address" /></span>
												</div>
											</li>
										</c:if>

										<c:if test="<%= websites == null || websites.isEmpty() %>">
											<li class="action-field aui-component aui-settings-field lfr-token">
												<div class="aui-settings-field-content">
													<span class="settings-label"><liferay-ui:message key="add-a-website" /></span>
												</div>
											</li>
										</c:if>

										<c:if test="<%= !hasSocialNetwork %>">
											<li class="action-field aui-component aui-settings-field lfr-token">
												<div class="aui-settings-field-content">
													<span class="settings-label" id=""><liferay-ui:message key="add-your-social-network" /></span>
												</div>
											</li>
										</c:if>

										<c:if test="<%= Validator.isNull(smsSn) %>">
											<li class="action-field aui-component aui-settings-field lfr-token">
												<div class="aui-settings-field-content">
													<span class="settings-label" id=""><liferay-ui:message key="add-your-sms" /></span>
												</div>
											</li>
										</c:if>

										<li class="action-field aui-component aui-settings-field lfr-token">
											<div class="aui-settings-field-content">
												<span class="settings-label"><liferay-ui:message key="add-an-expertise" /></span>
											</div>
										</li>
									</ul>
								</div>
							</c:if>
						</div>
					</aui:column>
				</c:if>
			</aui:layout>

			<c:if test="<%= showRecentActivity %>">
				<div class="user-information-title">
					<liferay-ui:message key="recent-activity" />
				</div>

				<liferay-ui:social-activities
					activities="<%= SocialActivityLocalServiceUtil.getUserActivities(user2.getUserId(), 0, 10) %>"
					feedEnabled="<%= false %>"
				/>
			</c:if>
		</c:if>
	</div>
</c:if>

<c:if test="<%= myProfile %>">
	<aui:script use="aui-editable,aui-io-request">
		var saveMessages = A.one('#<portlet:namespace/>saveMessages');

		var updateMessage = function(message, type) {
			saveMessages.html('<span class="portlet-msg-' + type + '">' + message + '</span>');
		};

		A.all('#p_p_id<portlet:namespace /> .quick-edit-field').each(
			function(node) {
				var fieldName = node.attr('data-fieldName');
				var elementId = node.attr('data-elementId');

				var inputType = node.attr('data-fieldType');

				if (!inputType) {
					inputType = 'text';
				}

				new A.Editable(
				{
					after: {
						contentTextChange: function(event) {
							var prevValue = event.prevVal;

							if (!event.initial) {
								A.io.request(
									'<portlet:actionURL name="saveMyProfileField"><portlet:param name="<%= Constants.CMD %>" value="saveMyProfileField" /></portlet:actionURL>()',
									{
										after: {
											failure: function(e, id, obj) {
												node.html(prevValue);

												updateMessage('<%= LanguageUtil.get(pageContext, "your-request-failed-to-complete") %>', 'error');
											},
											success: function(e, id, obj) {
												var responseData = this.get('responseData');

												if (!responseData.success) {
													node.html(prevValue);

													updateMessage(responseData.message, 'error');
												}
												else {
													updateMessage(responseData.message, 'success');
												}
											}
										},
										data: {
											fieldName: fieldName,
											value: event.newVal,
											elementId: elementId
										},
										dataType: 'json'
									}
								);
							}
						}
					},
					inputType: inputType,
					node: node
				});
			}
		);
	</aui:script>
</c:if>