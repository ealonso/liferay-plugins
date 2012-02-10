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

List<Phone> phones = (List<Phone>)request.getAttribute("view_user.jsp-phones");
List<EmailAddress> emailAddresses = (List<EmailAddress>)request.getAttribute("view_user.jsp-emailAddresses");
List<Address> addresses = (List<Address>)request.getAttribute("view_user.jsp-addresses");
List<Website> websites = (List<Website>)request.getAttribute("view_user.jsp-websites");

boolean hasInstantMessenger = (Boolean)request.getAttribute("view_user.jsp-hasInstantMessenger");

boolean hasSocialNetwork = (Boolean)request.getAttribute("view_user.jsp-hasSocialNetwork");
%>

<div class="user-information-title">
	<liferay-ui:message key="about" />
</div>

<c:if test="<%= showComments && Validator.isNotNull(user2.getComments()) %>">
	<div class="section field-container" data-namespaceId="<portlet:namespace />comments" data-title="comments">
		<div class="field-actions-toolbar yui3-widget-hd">
			<h3><liferay-ui:message key="Introduction" />:</h3>
		</div>

		<div class="field-values">
			<ul class="property-list">
				<li>
					<span class="property"><%= HtmlUtil.escape(user2.getComments()) %></span>
				</li>
			</ul>
		</div>
	</div>
</c:if>

<c:if test="<%= showPhones && ValidatorUtil.isNotNull(phones) %>">
	<div class="section field-container" data-namespaceId="<portlet:namespace />phoneNumbers" data-title="phone-numbers">
		<div class="field-actions-toolbar yui3-widget-hd">
			<h3><liferay-ui:message key="phones" />:</h3>
		</div>

		<div class="field-values">
			<ul class="property-list" id="phones-list">

				<%
				for (Phone phone : phones) {
					phone = phone.toEscapedModel();
				%>

					<li class="<%= phone.isPrimary() ? "primary" : "" %>">
						<span class="property-type"><%= LanguageUtil.get(pageContext, phone.getType().getName()) %></span>
						<span class="property"><%= phone.getNumber() %> <%= phone.getExtension() %></span>
					</li>

				<%
				}
				%>

			</ul>
		</div>
	</div>
</c:if>

<c:if test="<%= showAdditionalEmailAddresses && ValidatorUtil.isNotNull(emailAddresses) %>">
	<div class="section field-container" data-namespaceId="<portlet:namespace />additionalEmailAddresses" data-title="additional-email-addresses">
		<div class="field-actions-toolbar yui3-widget-hd">
			<h3><liferay-ui:message key="additional-email-addresses" />:</h3>
		</div>

		<div class="field-values">
			<ul class="property-list">

				<%
				for (EmailAddress emailAddress : emailAddresses) {
					emailAddress = emailAddress.toEscapedModel();
				%>

					<li class="<%= emailAddress.isPrimary() ? "primary" : "" %>">
						<span class="property-type"><%= LanguageUtil.get(pageContext, emailAddress.getType().getName()) %></span>
						<span class="property"><a href="mailto:<%= emailAddress.getAddress() %>"><%= emailAddress.getAddress() %></a></span>
					</li>

				<%
				}
				%>

			</ul>
		</div>
	</div>
</c:if>

<%
String aim = contact2.getAimSn();
String icq = contact2.getIcqSn();
String jabber = contact2.getJabberSn();
String msn = contact2.getMsnSn();
String skype = contact2.getSkypeSn();
String ym = contact2.getYmSn();
%>

<c:if test="<%= showInstantMessenger && hasInstantMessenger %>">
	<div class="section field-container" data-namespaceId="<portlet:namespace />instantMessenger" data-title="instant-messenger">
		<div class="field-actions-toolbar yui3-widget-hd">
			<h3><liferay-ui:message key="instant-messenger" />:</h3>
		</div>

		<div class="field-values">
			<ul class="property-list">
				<c:if test="<%= Validator.isNotNull(aim) %>">
					<li>
						<span class="property-type"><liferay-ui:message key="aim" /></span>

						<span class="property"><%= HtmlUtil.escape(aim) %></span>
					</li>
				</c:if>

				<c:if test="<%= Validator.isNotNull(icq) %>">
					<li>
						<span class="property-type"><liferay-ui:message key="icq" /></span>

						<span class="property"><%= HtmlUtil.escape(icq) %></span>

						<img alt="" class="instant-messenger-logo" src="http://web.icq.com/whitepages/online?icq=<%= HtmlUtil.escapeAttribute(icq) %>&img=5" />
					</li>
				</c:if>

				<c:if test="<%= Validator.isNotNull(jabber) %>">
					<li>
						<span class="property-type"><liferay-ui:message key="jabber" /></span>

						<span class="property"><%= HtmlUtil.escape(jabber) %></span>
					</li>
				</c:if>

				<c:if test="<%= Validator.isNotNull(msn) %>">
					<li>
						<span class="property-type"><liferay-ui:message key="msn" /></span>

						<span class="property"><%= HtmlUtil.escape(msn) %></span>
					</li>
				</c:if>

				<c:if test="<%= Validator.isNotNull(skype) %>">
					<li>
						<span class="property-type"><liferay-ui:message key="skype" /></span>

						<span class="property"><%= HtmlUtil.escape(skype) %></span>
					</li>
				</c:if>

				<c:if test="<%= Validator.isNotNull(ym) %>">
					<li>
						<span class="property-type"><liferay-ui:message key="ym" /></span>

						<span class="property"><%= HtmlUtil.escape(ym) %></span>

						<img alt="" class="instant-messenger-logo" src="http://opi.yahoo.com/online?u=<%= HtmlUtil.escapeAttribute(ym) %>&m=g&t=0" />
					</li>
				</c:if>
			</ul>
		</div>
	</div>
</c:if>

<c:if test="<%= showAddresses && ValidatorUtil.isNotNull(addresses) %>">
	<div class="section field-container" data-namespaceId="<portlet:namespace />addresses" data-title="addresses">
		<div class="field-actions-toolbar yui3-widget-hd">
			<h3><liferay-ui:message key="addresses" />:</h3>
		</div>

		<div class="field-values">
			<ul class="property-list">

				<%
				for (Address address: addresses) {
					String street1 = address.getStreet1();
					String street2 = address.getStreet2();
					String street3 = address.getStreet3();

					String zipCode = address.getZip();
					String city = address.getCity();

					Country country = address.getCountry();

					String countryName = StringPool.BLANK;

					if (country != null) {
						countryName = country.getName();
					}

					Region region = address.getRegion();

					String regionName = StringPool.BLANK;

					if (region != null) {
						regionName = region.getName();
					}

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

<<<<<<< HEAD
					<c:if test="<%= Validator.isNotNull(zipCode) %>">
						<%= zipCode %>,
					</c:if>

					<c:if test="<%= Validator.isNotNull(regionName) %>">
						<%= regionName %>,
					</c:if>

					<c:if test="<%= Validator.isNotNull(countryName) %>">
						<%= countryName %>
					</c:if>
=======
						<c:if test="<%= Validator.isNotNull(zipCode) %>">
							<%= zipCode %>
						</c:if>
>>>>>>> SOS-767 Edit user profile inline

						<c:if test="<%= address.isMailing() %>">(<liferay-ui:message key="mailing" />)</c:if>
					</li>

				<%
				}
				%>

			</ul>
		</div>
	</div>
</c:if>

<c:if test="<%= showWebsites && ValidatorUtil.isNotNull(websites) %>">
	<div class="section field-container" data-namespaceId="<portlet:namespace />websites" data-title="websites">
		<div class="field-actions-toolbar yui3-widget-hd">
			<h3><liferay-ui:message key="websites" />:</h3>
		</div>

		<div class="field-values">
			<ul class="property-list">

				<%
				for (Website website : websites) {
					website = website.toEscapedModel();
				%>

					<li class="<%= website.isPrimary() ? "primary" : "" %>">
						<span class="property-type"><%= LanguageUtil.get(pageContext, website.getType().getName()) %></span>

						<span class="property"><a href="<%= website.getUrl() %>"><%= website.getUrl() %></a></span>
					</li>

				<%
				}
				%>

			</ul>
		</div>
	</div>
</c:if>

<%
String facebook = contact2.getFacebookSn();
String mySpace = contact2.getMySpaceSn();
String twitter = contact2.getTwitterSn();
%>

<c:if test="<%= showSocialNetwork && hasSocialNetwork %>">
	<div class="section field-container" data-namespaceId="<portlet:namespace />socialNetwork" data-title="social-network">
		<div class="field-actions-toolbar yui3-widget-hd">
			<h3><liferay-ui:message key="social-network" />:</h3>
		</div>

		<div class="field-values">
			<ul class="property-list">
				<li>
					<span class="property-type"><liferay-ui:message key="facebook" /></span>

					<%= HtmlUtil.escape(facebook) %>
				</li>

				<li>
					<span class="property-type"><liferay-ui:message key="myspace" /></span>
					<%= HtmlUtil.escape(mySpace) %>
				</li>

				<li>
					<span class="property-type"><liferay-ui:message key="twitter" /></span>
					<%= HtmlUtil.escape(twitter) %>
				</li>
			</ul>
		</div>
	</div>
</c:if>

<c:if test="<%= showSMS && Validator.isNotNull(contact2.getSmsSn()) %>">
	<div class="section field-container" data-namespaceId="<portlet:namespace />sms" data-title="sms">
		<div class="field-actions-toolbar yui3-widget-hd">
			<h3><liferay-ui:message key="sms" />:</h3>
		</div>

		<div class="field-values">
			<ul class="property-list">
				<li class="property">
				<%= HtmlUtil.escape(contact2.getSmsSn()) %>
				</li>
			</ul>
		</div>
	</div>
</c:if>