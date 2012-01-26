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
User user2 = (User)request.getAttribute("view_user.jsp-user");

Contact contact2 = user2.getContact();

String editableClass = (String)request.getAttribute("view_user.jsp-editableClass");
%>

<c:if test="<%= showComments %>">
	<div class="section lfr-user-comments">
		<h3><liferay-ui:message key="Introduction" />:</h3>

		<ul class="property-list">
			<li>
				<c:choose>
					<c:when test="<%= user2.getUserId() == themeDisplay.getUser().getUserId() %>">
						<div class="<%= editableClass %>" data-fieldName="comments">
							<span class="property"><%= Validator.isNotNull(user2.getComments()) ? HtmlUtil.escape(user2.getComments()) : LanguageUtil.get(pageContext,  "add-your-introduction-here") %></span>
						</div>
					</c:when>
					<c:otherwise>
							<span class="property"><%= HtmlUtil.escape(user2.getComments()) %></span>
					</c:otherwise>
				</c:choose>
			</li>
		</ul>
	</div>
</c:if>

<%
List<Phone> phones = PhoneServiceUtil.getPhones(Contact.class.getName(), contact2.getContactId());
%>

<c:if test="<%= showPhones && !phones.isEmpty() %>">
	<div class="section lfr-user-phones">
		<h3><liferay-ui:message key="phones" />:</h3>

		<ul class="property-list">

			<%
			for (Phone phone : phones) {
				phone = phone.toEscapedModel();
			%>

				<li class="<%= phone.isPrimary() ? "primary" : "" %>">
					<span class="property-type"><%= LanguageUtil.get(pageContext, phone.getType().getName()) %></span>
					<div class="<%= editableClass %>" data-fieldName="phone" data-elementId="<%= phone.getPhoneId() %>">
						<span class="property"><%= phone.getNumber() %> <%= phone.getExtension() %></span>
					</div>
				</li>

			<%
			}
			%>

		</ul>
	</div>
</c:if>

<%
List<EmailAddress> emailAddresses = EmailAddressServiceUtil.getEmailAddresses(Contact.class.getName(), contact2.getContactId());
%>

<c:if test="<%= showAdditionalEmailAddresses && !emailAddresses.isEmpty() %>">
	<div class="section lfr-user-email-addresses">
		<h3><liferay-ui:message key="additional-email-addresses" />:</h3>

		<ul class="property-list">

			<%
			for (EmailAddress emailAddress : emailAddresses) {
				emailAddress = emailAddress.toEscapedModel();
			%>

				<li class="<%= emailAddress.isPrimary() ? "primary" : "" %>">
					<span class="property-type"><%= LanguageUtil.get(pageContext, emailAddress.getType().getName()) %></span>

					<span class="property">
						<div class="<%= editableClass %>" data-fieldName="additionalEmailAddress" data-elementId="<%= emailAddress.getEmailAddressId() %>">
							<c:choose>
								<c:when test="<%= user2.getUserId() == themeDisplay.getUser().getUserId() %>">
									<%= emailAddress.getAddress() %>
								</c:when>
								<c:otherwise>
									<a href="mailto:<%= emailAddress.getAddress() %>"><%= emailAddress.getAddress() %></a>
								</c:otherwise>
							</c:choose>
						</div>
					</span>
				</li>

			<%
			}
			%>

		</ul>
	</div>
</c:if>

<%
String aimSn = contact2.getAimSn();
String icqSn = contact2.getIcqSn();
String jabberSn = contact2.getJabberSn();
String msnSn = contact2.getMsnSn();
String skypeSn = contact2.getSkypeSn();
String ymSn = contact2.getYmSn();
%>

<c:if test="<%= showInstantMessenger && (Validator.isNotNull(aimSn) || Validator.isNotNull(icqSn) || Validator.isNotNull(jabberSn) || Validator.isNotNull(msnSn) || Validator.isNotNull(skypeSn) || Validator.isNotNull(ymSn)) %>">
	<div class="section lfr-user-instant-messenger">
		<h3><liferay-ui:message key="instant-messenger" />:</h3>

		<ul class="property-list">
			<c:if test="<%= Validator.isNotNull(aimSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="aim" /></span>

					<span class="<%= editableClass %>" data-fieldName="aimSn">
						<%= HtmlUtil.escape(aimSn) %>
					</span>
				</li>
			</c:if>

			<c:if test="<%= Validator.isNotNull(icqSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="icq" /></span>

					<span class="<%= editableClass %>" data-fieldName="icqSn">
						<%= HtmlUtil.escape(icqSn) %>
					</span>

					<img alt="" class="instant-messenger-logo" src="http://web.icq.com/whitepages/online?icq=<%= HtmlUtil.escapeAttribute(icqSn) %>&img=5" />
				</li>
			</c:if>

			<c:if test="<%= Validator.isNotNull(jabberSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="jabber" /></span>

					<span class="<%= editableClass %>" data-fieldName="jabberSn">
						<%= HtmlUtil.escape(jabberSn) %>
					</span>
				</li>
			</c:if>

			<c:if test="<%= Validator.isNotNull(msnSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="msn" /></span>

					<span class="<%= editableClass %>" data-fieldName="msnSn">
						<%= HtmlUtil.escape(msnSn) %>
					</span>
				</li>
			</c:if>

			<c:if test="<%= Validator.isNotNull(skypeSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="skype" /></span>

					<span class="<%= editableClass %>" data-fieldName="skypeSn">
						<%= HtmlUtil.escape(skypeSn) %>
					</span>
				</li>
			</c:if>

			<c:if test="<%= Validator.isNotNull(ymSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="ym" /></span>

					<span class="<%= editableClass %>" data-fieldName="ymSn">
						<%= HtmlUtil.escape(ymSn) %>
					</span>

					<img alt="" class="instant-messenger-logo" src="http://opi.yahoo.com/online?u=<%= HtmlUtil.escapeAttribute(ymSn) %>&m=g&t=0" />
				</li>
			</c:if>
		</ul>
	</div>
</c:if>

<%
List<Address> addresses = AddressServiceUtil.getAddresses(Contact.class.getName(), contact2.getContactId());
%>

<c:if test="<%= showAddresses && !addresses.isEmpty() %>">
	<div class="section lfr-user-addresses">
		<h3><liferay-ui:message key="addresses" />:</h3>

		<ul class="property-list">

			<%
			for (Address address: addresses) {
				String street1 = address.getStreet1();
				String street2 = address.getStreet2();
				String street3 = address.getStreet3();

				String zipCode = address.getZip();
				String city = address.getCity();

				String mailingName = LanguageUtil.get(pageContext, address.getType().getName());
			%>

				<li class="<%= address.isPrimary() ? "primary" : "" %>">
					<span class="property-type"><%= mailingName %></span>

					<c:if test="<%= Validator.isNotNull(street1) %>">
						<%= HtmlUtil.escape(street1) %>,
					</c:if>

					<c:if test="<%= Validator.isNotNull(street2) %>">
						<%= HtmlUtil.escape(street2) %>,
					</c:if>

					<c:if test="<%= Validator.isNotNull(street3) %>">
						<%= HtmlUtil.escape(street3) %>,
					</c:if>

					<c:if test="<%= Validator.isNotNull(city) %>">
						<%= HtmlUtil.escape(city) %>,
					</c:if>

					<c:if test="<%= Validator.isNotNull(zipCode) %>">
						<%= zipCode %>
					</c:if>

					<c:if test="<%= address.isMailing() %>">(<liferay-ui:message key="mailing" />)</c:if>
				</li>

			<%
			}
			%>

		</ul>
	</div>
</c:if>

<%
List<Website> websites = WebsiteServiceUtil.getWebsites(Contact.class.getName(), contact2.getContactId());
%>

<c:if test="<%= showWebsites && !websites.isEmpty() %>">
	<div class="section lfr-user-websites">
		<h3><liferay-ui:message key="websites" />:</h3>

		<ul class="property-list">

			<%
			for (Website website : websites) {
				website = website.toEscapedModel();
			%>


				<li class="<%= website.isPrimary() ? "primary" : "" %>">
					<span class="property-type"><%= LanguageUtil.get(pageContext, website.getType().getName()) %></span>

					<span class="property">
						<div class="<%= editableClass %>" data-fieldName="website" data-elementId="<%= website.getWebsiteId() %>">
							<c:choose>
								<c:when test="<%= user2.getUserId() == themeDisplay.getUser().getUserId() %>">
									<%= website.getUrl() %>
								</c:when>
								<c:otherwise>
									<a href="<%= website.getUrl() %>"><%= website.getUrl() %></a>
								</c:otherwise>
							</c:choose>
						</div>
					</span>
				</li>

			<%
			}
			%>

		</ul>
	</div>
</c:if>

<%
String facebookSn = contact2.getFacebookSn();
String mySpaceSn = contact2.getMySpaceSn();
String twitterSn = contact2.getTwitterSn();
%>

<c:if test="<%= showSocialNetwork && (Validator.isNotNull(facebookSn) || Validator.isNotNull(mySpaceSn) || Validator.isNotNull(twitterSn)) %>">
	<div class="section lfr-user-social-network">
		<h3><liferay-ui:message key="social-network" />:</h3>

		<ul class="property-list">
			<c:if test="<%= Validator.isNotNull(facebookSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="facebook" /></span>

					<div class="<%= editableClass %>" data-fieldName="facebookSn">
						<%= HtmlUtil.escape(facebookSn) %>
					</div>
				</li>
			</c:if>

			<c:if test="<%= Validator.isNotNull(mySpaceSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="myspace" /></span>

					<div class="<%= editableClass %>" data-fieldName="myspaceSn">
						<%= HtmlUtil.escape(mySpaceSn) %>
					</div>
				</li>
			</c:if>

			<c:if test="<%= Validator.isNotNull(twitterSn) %>">
				<li>
					<span class="property-type"><liferay-ui:message key="twitter" /></span>

					<div class="<%= editableClass %>" data-fieldName="twitterSn">
						<%= HtmlUtil.escape(twitterSn) %>
					</div>
				</li>
			</c:if>
		</dl>
	</div>
</c:if>

<c:if test="<%= showSMS && Validator.isNotNull(contact2.getSmsSn()) %>">
	<div class="section lfr-user-sms">
		<h3><liferay-ui:message key="sms" />:</h3>

		<ul class="property-list">
			<li class="property">
				<div class="<%= editableClass %>" data-fieldName="smsSn">
					<%= HtmlUtil.escape(contact2.getSmsSn()) %>
				</div>
			</li>
		</ul>
	</div>
</c:if>