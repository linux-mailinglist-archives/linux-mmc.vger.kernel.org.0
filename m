Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA54BC0A2
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Sep 2019 05:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394752AbfIXDNh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 23:13:37 -0400
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:58682
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394621AbfIXDNh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Sep 2019 23:13:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty2gPs516xPIdPtSKe8euWXYwRLv0BtueH5+MjaWQiEZxO2mSCbNzWG/jImGkznR09a3DNSa1nb6bXowN9ZNzm8MMI0+7CGIemkmzno2Q6R+G/8bwazo52Hx12XLY6af6Tc8s17meTbby4AvmJOnUAPSC9jqC1+cIPxVHb2HAKHv1d+Vt6BV1rHmYogGx/S/tWHKmMDPKbXofSquMyb1MwcvRLqC/geBZBWgItPEKaFi4EJtiePGhaW/xGDtechCpWEMMgsj7M5rwnWJkyyuL279dJo+Tp6ajsLtEpX4FurMaN/qwlx+X32XB4aqJUEx5NOAavH8GmRm1YZ60efeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUS6CT1CsgYrA4Rjl/fIDnWmDn5LyS9t7O175cPENJc=;
 b=eoUFl3wJP7Ps9H+OGPKzB7CO1XBHlZx1g5+kE5Ozco1WkWGIJhI60CQ+F3v1OAgQDlcG1yNYMdHNIN9hWjZqTB6aj6Dr61jzVv0RIXFsEi1quiaIhHka5qEcVYA+OyO/iKmsM4yqfG+bp6tK1TSj+WrNfo4/Iv/cn0QFTW+echp6vah5WwmPXhlh5MWLgicWz2QemBiXUCHv8AIvx4ye8AGHNbokHIzHYx0UAAD4lGUMHk2qgsrMR6qTcmKdpJK5yJGKy41BU4/Q6snNHW9bbJEloK5dKOpmZY1NzjOpA8uYc1FLHsavNNl03/rpuK1r7/hN/46rpdQczQxpi0YRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUS6CT1CsgYrA4Rjl/fIDnWmDn5LyS9t7O175cPENJc=;
 b=EHSo4818oHHBxgYGYIn5xnBNBAKF4nw9VIZJuyAHFq/Ih4OTVQ3nLONmGbZRbTldgdWaUZAvzEImoPstPLRZLG7W8cZilFdCiZ2/8lRHn6OtRPnl+QO3WrcgACVfE/qUrOBxo27PPHhANe/8GYO2mkmnedLuTrbl/RjWm+TWnTg=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2238.eurprd04.prod.outlook.com (10.169.133.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Tue, 24 Sep 2019 03:11:49 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::40fb:b35c:722a:101f]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::40fb:b35c:722a:101f%10]) with mapi id 15.20.2284.023; Tue, 24 Sep
 2019 03:11:49 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH 3/3] mmc: sdhci-of-esdhc: fix up erratum A-008171
 workaround
Thread-Topic: [PATCH 3/3] mmc: sdhci-of-esdhc: fix up erratum A-008171
 workaround
Thread-Index: AQHVbRKtstc6c3+3f0SSBpVZCYSXfqc5QmuAgADst5A=
Date:   Tue, 24 Sep 2019 03:11:49 +0000
Message-ID: <VI1PR0401MB22373BC252B36CF32C2AFB4EF8840@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20190917044631.3161-1-yangbo.lu@nxp.com>
 <20190917044631.3161-4-yangbo.lu@nxp.com>
 <0e8f0c12-093f-4235-27ec-88db734fa662@intel.com>
In-Reply-To: <0e8f0c12-093f-4235-27ec-88db734fa662@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1968f4c7-2d3c-4428-af08-08d7409cf0f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2238;
x-ms-traffictypediagnostic: VI1PR0401MB2238:|VI1PR0401MB2238:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB22383EB1CFDD7288DE402BEEF8840@VI1PR0401MB2238.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(13464003)(199004)(189003)(71190400001)(11346002)(256004)(53546011)(71200400001)(7736002)(81156014)(446003)(7696005)(86362001)(186003)(486006)(476003)(6246003)(2906002)(66476007)(66556008)(64756008)(66446008)(66946007)(66066001)(76176011)(26005)(8676002)(52536014)(305945005)(6506007)(102836004)(81166006)(110136005)(55016002)(478600001)(4326008)(14444005)(9686003)(76116006)(5660300002)(229853002)(6116002)(99286004)(3846002)(25786009)(2501003)(74316002)(33656002)(316002)(8936002)(14454004)(30864003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2238;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WrXxSKnWGm2nxFXhPRuImfeiOnD0L0FqL2p1AZLTLrWrsDFdWndk8x2ML8qFz3bSKrR8XtUUMgOS8+Jz3NtHeAVmSV44+BEpYrsnznqQFP1Rc6akRBDYnovlfz6eO9umEXGSrAwh1ZdOpG4fVmTs0r2esQC/x84lNQWkn8NNN34RcyA1KEcZ78K7tbtAZIYBsxX00GpeKINAHTeB7Fcwy2H/xvsAuwxhJ7xAzf1oC1KBE1v1WQWPyeSjiSW85lBMzlLRG1asndLwMUAEB8TAt0rNU/mEwEym/WQUApXve2R9+bNTUpntMg7dEgvCChSs2ASxsMBRlbJS5M+7NSpuYhMLtolY+4ptwAljvxxXW45CbBLrwsNAv+5oEffbX0L6VGZB6mxXkWxa+k/pLjyZRDiIyOOIHV5O3agftUtHI8c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1968f4c7-2d3c-4428-af08-08d7409cf0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 03:11:49.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0SMN6WEdq8rVYdx6LalVmzIdBnmaPccjNK0SqwFewJS1MdS0u+h+4lTCgiOl6rZtlBMz6jYdDxXXcd44GNBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2238
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQWRyaWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4
LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5v
cmc+DQo+IE9uIEJlaGFsZiBPZiBBZHJpYW4gSHVudGVyDQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVt
YmVyIDIzLCAyMDE5IDg6NTYgUE0NCj4gVG86IFkuYi4gTHUgPHlhbmdiby5sdUBueHAuY29tPjsg
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgVWxmIEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxp
bmFyby5vcmc+DQo+IENjOiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDMvM10gbW1jOiBzZGhjaS1vZi1lc2RoYzogZml4IHVwIGVycmF0dW0gQS0w
MDgxNzENCj4gd29ya2Fyb3VuZA0KPiANCj4gT24gMTcvMDkvMTkgNzo0NiBBTSwgWWFuZ2JvIEx1
IHdyb3RlOg0KPiA+IEEgcHJldmlvdXMgcGF0Y2ggaW1wbGVtZW50ZWQgYW4gaW5jb21wbGV0ZSB3
b3JrYXJvdW5kIG9mIGVycmF0dW0NCj4gPiBBLTAwODE3MS4gVGhlIGNvbXBsZXRlIHdvcmthcm91
bmQgaXMgYXMgYmVsb3cuIFRoaXMgcGF0Y2ggaXMgdG8NCj4gPiBpbXBsZW1lbnQgdGhlIGNvbXBs
ZXRlIHdvcmthcm91bmQgd2hpY2ggdXNlcyBTVyB0dW5pbmcgaWYgSFcgdHVuaW5nDQo+ID4gZmFp
bHMsIGFuZCByZXRyaWVzIGJvdGggSFcvU1cgdHVuaW5nIG9uY2Ugd2l0aCByZWR1Y2VkIGNsb2Nr
IGlmDQo+ID4gd29ya2Fyb3VuZCBmYWlscy4gVGhpcyBpcyBzdWdnZXN0ZWQgYnkgaGFyZHdhcmUg
dGVhbSwgYW5kIHRoZSBwYXRjaA0KPiA+IGhhZCBiZWVuIHZlcmlmaWVkIG9uIExTMTA0NkEgZVNE
SEMgKyBQaGlzb24gMzJHIGVNTUMgd2hpY2ggY291bGQNCj4gPiB0cmlnZ2VyIHRoZSBlcnJhdHVt
Lg0KPiA+DQo+ID4gV29ya2Fyb3VuZDoNCj4gPiAvKiBGb3IgVDEwNDAsIFQyMDgwLCBMUzEwMjFB
LCBUMTAyMyBSZXYgMTogKi8gMS4gUHJvZ3JhbQ0KPiA+IFRCUFRSW1RCX1dORFdfRU5EX1BUUl0g
PSAzKkRJVl9SQVRJTy4NCj4gPiAyLiBQcm9ncmFtIFRCUFRSW1RCX1dORFdfU1RBUlRfUFRSXSA9
IDUqRElWX1JBVElPLg0KPiA+IDMuIFByb2dyYW0gdGhlIHNvZnR3YXJlIHR1bmluZyBtb2RlIGJ5
IHNldHRpbmcgVEJDVExbVEJfTU9ERV0gPSAyJ2gzLg0KPiA+IDQuIFNldCBTWVNDVEwyW0VYVE5d
IGFuZCBTWVNDVEwyW1NBTVBDTEtTRUxdLg0KPiA+IDUuIElzc3VlIFNFTkRfVFVOSU5HX0JMSyBD
b21tYW5kIChDTUQxOSBmb3IgU0QsIENNRDIxIGZvciBNTUMpLg0KPiA+IDYuIFdhaXQgZm9yIElS
UVNUQVRbQlJSXSwgYnVmZmVyIHJlYWQgcmVhZHksIHRvIGJlIHNldC4NCj4gPiA3LiBDbGVhciBJ
UlFTVEFUW0JSUl0uDQo+ID4gOC4gQ2hlY2sgU1lTQ1RMMltFWFROXSB0byBiZSBjbGVhcmVkLg0K
PiA+IDkuIENoZWNrIFNZU0NUTDJbU0FNUENMS1NFTF0sIFNhbXBsaW5nIENsb2NrIFNlbGVjdC4g
SXQncyBzZXQgdmFsdWUNCj4gPiAgICBpbmRpY2F0ZSB0dW5pbmcgcHJvY2VkdXJlIHN1Y2Nlc3Ms
IGFuZCBjbGVhciBpbmRpY2F0ZSBmYWlsdXJlLg0KPiA+ICAgIEluIGNhc2Ugb2YgdHVuaW5nIGZh
aWx1cmUsIGZpeGVkIHNhbXBsaW5nIHNjaGVtZSBjb3VsZCBiZSB1c2VkIGJ5DQo+ID4gICAgY2xl
YXJpbmcgVEJDVExbVEJfRU5dLg0KPiA+IC8qIEZvciBMUzEwODBBIFJldiAxLCBMUzIwODhBIFJl
diAxLjAsIExBMTU3NUEgUmV2IDEuMDogKi8gMS4gUmVhZCB0aGUNCj4gPiBUQkNUTFszMTowXSBy
ZWdpc3Rlci4gV3JpdGUgVEJDVExbMTE6OF09NCdoOCBhbmQgd2FpdCBmb3INCj4gPiAgICAxbXMu
DQo+ID4gMi4gUmVhZCB0aGUgVEJDVExbMzE6MF0gcmVnaXN0ZXIgYW5kIHJld3JpdGUgYWdhaW4u
IFdhaXQgZm9yIDFtcyBzZWNvbmQuDQo+ID4gMy4gUmVhZCB0aGUgVEJTVEFUWzMxOjBdIHJlZ2lz
dGVyIHR3aWNlLg0KPiA+IDMuMSBSZXNldCBkYXRhIGxpbmVzIGJ5IHNldHRpbmcgRVNESENDVExb
UlNURF0gYml0Lg0KPiA+IDMuMiBDaGVjayBFU0RIQ0NUTFtSU1REXSBiaXQuDQo+ID4gMy4zIElm
IEVTREhDQ1RMW1JTVERdIGlzIDAsIGdvIHRvIHN0ZXAgMy40IGVsc2UgZ28gdG8gc3RlcCAzLjIu
DQo+ID4gMy40IFdyaXRlIDMyJ2hGRkZGX0ZGRkYgdG8gSVJRU1RBVCByZWdpc3Rlci4NCj4gPiA0
LiBpZiBUQlNUQVRbMTU6OF0tVEJTVEFUWzc6MF0gPiA0KkRJVl9SQVRJTyBvciBUQlNUQVRbNzow
XS1UQlNUQVRbMTU6OF0NCj4gPiAgICA+IDQqRElWX1JBVElPICwgdGhlbiBwcm9ncmFtIFRCUFRS
W1RCX1dORFdfRU5EX1BUUl0gPQ0KPiA0KkRJVl9SQVRJTyBhbmQNCj4gPiAgICBwcm9ncmFtIFRC
UFRSW1RCX1dORFdfU1RBUlRfUFRSXSA9IDgqRElWX1JBVElPLg0KPiA+IC8qIEZvciBMUzEwMTJB
IFJldjEsIExTMTA0M0EgUmV2IDEueCwgTFMxMDQ2QSAxLjA6ICovIDEuIFJlYWQgdGhlDQo+ID4g
VEJDVExbMDozMV0gcmVnaXN0ZXIuIFdyaXRlIFRCQ1RMWzIwOjIzXT00J2g4IGFuZCB3YWl0IGZv
cg0KPiA+ICAgIDFtcy4NCj4gPiAyLiBSZWFkIHRoZSBUQkNUTFswOjMxXSByZWdpc3RlciBhbmQg
cmV3cml0ZSBhZ2Fpbi4gV2FpdCBmb3IgMW1zIHNlY29uZC4NCj4gPiAzLiBSZWFkIHRoZSBUQlNU
QVRbMDozMV0gcmVnaXN0ZXIgdHdpY2UuDQo+ID4gMy4xIFJlc2V0IGRhdGEgbGluZXMgYnkgc2V0
dGluZyBFU0RIQ0NUTFtSU1REXSBiaXQuDQo+ID4gMy4yIENoZWNrIEVTREhDQ1RMW1JTVERdIGJp
dC4NCj4gPiAzLjMgSWYgRVNESENDVExbUlNURF0gaXMgMCwgZ28gdG8gc3RlcCAzLjQgZWxzZSBn
byB0byBzdGVwIDMuMi4NCj4gPiAzLjQgV3JpdGUgMzInaEZGRkZfRkZGRiB0byBJUlFTVEFUIHJl
Z2lzdGVyLg0KPiA+IDQuIGlmIFRCU1RBVFsxNjoyM10tVEJTVEFUWzI0OjMxXSA+IDQqRElWX1JB
VElPIG9yIFRCU1RBVFsyNDozMV0tDQo+ID4gICAgVEJTVEFUWzE2OjIzXSA+IDQqIERJVl9SQVRJ
TyAsIHRoZW4gcHJvZ3JhbQ0KPiBUQlBUUltUQl9XTkRXX0VORF9QVFJdID0NCj4gPiAgICA0KkRJ
Vl9SQVRJTyBhbmQgcHJvZ3JhbSBUQlBUUltUQl9XTkRXX1NUQVJUX1BUUl0gPQ0KPiA4KkRJVl9S
QVRJTy4NCj4gPiAvKiBGb3IgTFMxMDgwQSBSZXYgMSwgTFMyMDg4QSBSZXYgMS4wLCBMQTE1NzVB
IFJldiAxLjAgTFMxMDEyQSBSZXYxLA0KPiA+ICAqIExTMTA0M0EgUmV2IDEueCwgTFMxMDQ2QSAx
LjA6DQo+ID4gICovDQo+ID4gNS4gZWxzZSBwcm9ncmFtIFRCUFRSW1RCX1dORFdfRU5EX1BUUl0g
PSAzKkRJVl9SQVRJTyBhbmQgcHJvZ3JhbQ0KPiA+ICAgIFRCUFRSW1RCX1dORFdfU1RBUlRfUFRS
XSA9IDUqRElWX1JBVElPLg0KPiA+IDYuIFByb2dyYW0gdGhlIHNvZnR3YXJlIHR1bmluZyBtb2Rl
IGJ5IHNldHRpbmcgVEJDVExbVEJfTU9ERV0gPSAyJ2gzLg0KPiA+IDcuIFNldCBTWVNDVEwyW0VY
VE5dLCB3YWl0IDF1cyBhbmQgU1lTQ1RMMltTQU1QQ0xLU0VMXS4NCj4gPiA4LiBJc3N1ZSBTRU5E
X1RVTklOR19CTEsgQ29tbWFuZCAoQ01EMTkgZm9yIFNELCBDTUQyMSBmb3IgTU1DKS4NCj4gPiA5
LiBXYWl0IGZvciBJUlFTVEFUW0JSUl0sIGJ1ZmZlciByZWFkIHJlYWR5LCB0byBiZSBzZXQuDQo+
ID4gMTAuIENsZWFyIElSUVNUQVRbQlJSXS4NCj4gPiAxMS4gQ2hlY2sgU1lTQ1RMMltFWFROXSB0
byBiZSBjbGVhcmVkLg0KPiA+IDEyLiBDaGVjayBTWVNDVEwyW1NBTVBDTEtTRUxdLCBTYW1wbGlu
ZyBDbG9jayBTZWxlY3QuIEl0J3Mgc2V0IHZhbHVlDQo+ID4gICAgIGluZGljYXRlIHR1bmluZyBw
cm9jZWR1cmUgc3VjY2VzcywgYW5kIGNsZWFyIGluZGljYXRlIGZhaWx1cmUuDQo+ID4gICAgIElu
IGNhc2Ugb2YgdHVuaW5nIGZhaWx1cmUsIGZpeGVkIHNhbXBsaW5nIHNjaGVtZSBjb3VsZCBiZSB1
c2VkIGJ5DQo+ID4gICAgIGNsZWFyaW5nIFRCQ1RMW1RCX0VOXS4NCj4gPg0KPiA+IEZpeGVzOiBi
MWYzNzhhYjUzMzQgKCJtbWM6IHNkaGNpLW9mLWVzZGhjOiBhZGQgZXJyYXR1bSBBMDA4MTcxDQo+
ID4gc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogWWluYm8gWmh1IDx5aW5iby56aHVAbnhw
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLmggICAgfCAgIDkgKysN
Cj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jIHwgMjE2DQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAx
OTIgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy5oDQo+ID4gYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLWVzZGhjLmggaW5kZXggNTdiNTgyYi4uZTg4ZGVlNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLmgNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLWVzZGhjLmgNCj4gPiBAQCAtNTksNyArNTksMTYgQEANCj4gPiAgI2RlZmluZSBFU0RIQ19I
UzQwMF9XTkRXX0FESlVTVAkJMHgwMDAwMDA0MA0KPiA+ICAjZGVmaW5lIEVTREhDX0hTNDAwX01P
REUJCTB4MDAwMDAwMTANCj4gPiAgI2RlZmluZSBFU0RIQ19UQl9FTgkJCTB4MDAwMDAwMDQNCj4g
PiArI2RlZmluZSBFU0RIQ19UQl9NT0RFX01BU0sJCTB4MDAwMDAwMDMNCj4gPiArI2RlZmluZSBF
U0RIQ19UQl9NT0RFX1NXCQkweDAwMDAwMDAzDQo+ID4gKyNkZWZpbmUgRVNESENfVEJfTU9ERV8z
CQkJMHgwMDAwMDAwMg0KPiA+ICsNCj4gPiArI2RlZmluZSBFU0RIQ19UQlNUQVQJCQkweDEyNA0K
PiA+ICsNCj4gPiAgI2RlZmluZSBFU0RIQ19UQlBUUgkJCTB4MTI4DQo+ID4gKyNkZWZpbmUgRVNE
SENfV05EV19TVFJUX1BUUl9TSElGVAk4DQo+ID4gKyNkZWZpbmUgRVNESENfV05EV19TVFJUX1BU
Ul9NQVNLCSgweDdmIDw8IDgpDQo+ID4gKyNkZWZpbmUgRVNESENfV05EV19FTkRfUFRSX01BU0sJ
CTB4N2YNCj4gPg0KPiA+ICAvKiBTRCBDbG9jayBDb250cm9sIFJlZ2lzdGVyICovDQo+ID4gICNk
ZWZpbmUgRVNESENfU0RDTEtDVEwJCQkweDE0NA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2Yt
ZXNkaGMuYw0KPiA+IGluZGV4IGEwMWQzYTUuLmVhOGQzNWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1vZi1lc2RoYy5jDQo+ID4gQEAgLTc3LDggKzc3LDEwIEBAIHN0cnVjdCBzZGhjaV9l
c2RoYyB7DQo+ID4gIAlib29sIHF1aXJrX2luY29ycmVjdF9ob3N0dmVyOw0KPiA+ICAJYm9vbCBx
dWlya19saW1pdGVkX2Nsa19kaXZpc2lvbjsNCj4gPiAgCWJvb2wgcXVpcmtfdW5yZWxpYWJsZV9w
dWxzZV9kZXRlY3Rpb247DQo+ID4gLQlib29sIHF1aXJrX2ZpeHVwX3R1bmluZzsNCj4gPiArCWJv
b2wgcXVpcmtfdHVuaW5nX2VycmF0dW1fdHlwZTE7DQo+ID4gKwlib29sIHF1aXJrX3R1bmluZ19l
cnJhdHVtX3R5cGUyOw0KPiA+ICAJYm9vbCBxdWlya19pZ25vcmVfZGF0YV9pbmhpYml0Ow0KPiA+
ICsJYm9vbCBpbl9zd190dW5pbmc7DQo+ID4gIAl1bnNpZ25lZCBpbnQgcGVyaXBoZXJhbF9jbG9j
azsNCj4gPiAgCWNvbnN0IHN0cnVjdCBlc2RoY19jbGtfZml4dXAgKmNsa19maXh1cDsNCj4gPiAg
CXUzMiBkaXZfcmF0aW87DQo+ID4gQEAgLTgwNiwxNiArODA4LDIxIEBAIHN0YXRpYyBpbnQgZXNk
aGNfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoKHN0cnVjdA0KPiBtbWNfaG9zdCAqbW1jLA0KPiA+ICAJ
fQ0KPiA+ICB9DQo+ID4NCj4gPiAtc3RhdGljIHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSBz
b2NfZml4dXBfdHVuaW5nW10gPSB7DQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgc29jX2RldmljZV9hdHRy
aWJ1dGUgc29jX3R1bmluZ19lcnJhdHVtX3R5cGUxW10gPSB7DQo+ID4gKwl7IC5mYW1pbHkgPSAi
UW9ySVEgVDEwMjMiLCAucmV2aXNpb24gPSAiMS4wIiwgfSwNCj4gPiAgCXsgLmZhbWlseSA9ICJR
b3JJUSBUMTA0MCIsIC5yZXZpc2lvbiA9ICIxLjAiLCB9LA0KPiA+ICAJeyAuZmFtaWx5ID0gIlFv
cklRIFQyMDgwIiwgLnJldmlzaW9uID0gIjEuMCIsIH0sDQo+ID4gLQl7IC5mYW1pbHkgPSAiUW9y
SVEgVDEwMjMiLCAucmV2aXNpb24gPSAiMS4wIiwgfSwNCj4gPiAgCXsgLmZhbWlseSA9ICJRb3JJ
USBMUzEwMjFBIiwgLnJldmlzaW9uID0gIjEuMCIsIH0sDQo+ID4gLQl7IC5mYW1pbHkgPSAiUW9y
SVEgTFMxMDgwQSIsIC5yZXZpc2lvbiA9ICIxLjAiLCB9LA0KPiA+IC0JeyAuZmFtaWx5ID0gIlFv
cklRIExTMjA4MEEiLCAucmV2aXNpb24gPSAiMS4wIiwgfSwNCj4gPiArCXsgfSwNCj4gPiArfTsN
Cj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgc29jX3R1bmlu
Z19lcnJhdHVtX3R5cGUyW10gPSB7DQo+ID4gIAl7IC5mYW1pbHkgPSAiUW9ySVEgTFMxMDEyQSIs
IC5yZXZpc2lvbiA9ICIxLjAiLCB9LA0KPiA+ICAJeyAuZmFtaWx5ID0gIlFvcklRIExTMTA0M0Ei
LCAucmV2aXNpb24gPSAiMS4qIiwgfSwNCj4gPiAgCXsgLmZhbWlseSA9ICJRb3JJUSBMUzEwNDZB
IiwgLnJldmlzaW9uID0gIjEuMCIsIH0sDQo+ID4gKwl7IC5mYW1pbHkgPSAiUW9ySVEgTFMxMDgw
QSIsIC5yZXZpc2lvbiA9ICIxLjAiLCB9LA0KPiA+ICsJeyAuZmFtaWx5ID0gIlFvcklRIExTMjA4
MEEiLCAucmV2aXNpb24gPSAiMS4wIiwgfSwNCj4gPiArCXsgLmZhbWlseSA9ICJRb3JJUSBMQTE1
NzVBIiwgLnJldmlzaW9uID0gIjEuMCIsIH0sDQo+ID4gIAl7IH0sDQo+ID4gIH07DQo+ID4NCj4g
PiBAQCAtODU2LDE1ICs4NjMsOTcgQEAgc3RhdGljIHZvaWQgZXNkaGNfdHVuaW5nX2Jsb2NrX2Vu
YWJsZShzdHJ1Y3QNCj4gc2RoY2lfaG9zdCAqaG9zdCwgYm9vbCBlbmFibGUpDQo+ID4gIAllc2Ro
Y19jbG9ja19lbmFibGUoaG9zdCwgdHJ1ZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9p
ZCBlc2RoY19wcmVwYXJlX3N3X3R1bmluZyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTgNCj4g
KndpbmRvd19zdGFydCwNCj4gPiArCQkJCSAgICB1OCAqd2luZG93X2VuZCkNCj4gPiArew0KPiA+
ICsJc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhjaV9wcml2KGhvc3Qp
Ow0KPiA+ICsJc3RydWN0IHNkaGNpX2VzZGhjICplc2RoYyA9IHNkaGNpX3BsdGZtX3ByaXYocGx0
Zm1faG9zdCk7DQo+ID4gKwl1OCB0YnN0YXRfMTVfOCwgdGJzdGF0XzdfMDsNCj4gPiArCXUzMiB2
YWw7DQo+ID4gKw0KPiA+ICsJaWYgKGVzZGhjLT5xdWlya190dW5pbmdfZXJyYXR1bV90eXBlMSkg
ew0KPiA+ICsJCSp3aW5kb3dfc3RhcnQgPSA1ICogZXNkaGMtPmRpdl9yYXRpbzsNCj4gPiArCQkq
d2luZG93X2VuZCA9IDMgKiBlc2RoYy0+ZGl2X3JhdGlvOw0KPiA+ICsJCXJldHVybjsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwkvKiBXcml0ZSBUQkNUTFsxMTo4XT00J2g4ICovDQo+ID4gKwl2YWwg
PSBzZGhjaV9yZWFkbChob3N0LCBFU0RIQ19UQkNUTCk7DQo+ID4gKwl2YWwgJj0gfigweGYgPDwg
OCk7DQo+ID4gKwl2YWwgfD0gOCA8PCA4Ow0KPiA+ICsJc2RoY2lfd3JpdGVsKGhvc3QsIHZhbCwg
RVNESENfVEJDVEwpOw0KPiA+ICsNCj4gPiArCW1kZWxheSgxKTsNCj4gPiArDQo+ID4gKwkvKiBS
ZWFkIFRCQ1RMWzMxOjBdIHJlZ2lzdGVyIGFuZCByZXdyaXRlIGFnYWluICovDQo+ID4gKwl2YWwg
PSBzZGhjaV9yZWFkbChob3N0LCBFU0RIQ19UQkNUTCk7DQo+ID4gKwlzZGhjaV93cml0ZWwoaG9z
dCwgdmFsLCBFU0RIQ19UQkNUTCk7DQo+ID4gKw0KPiA+ICsJbWRlbGF5KDEpOw0KPiA+ICsNCj4g
PiArCS8qIFJlYWQgdGhlIFRCU1RBVFszMTowXSByZWdpc3RlciB0d2ljZSAqLw0KPiA+ICsJdmFs
ID0gc2RoY2lfcmVhZGwoaG9zdCwgRVNESENfVEJTVEFUKTsNCj4gPiArCXZhbCA9IHNkaGNpX3Jl
YWRsKGhvc3QsIEVTREhDX1RCU1RBVCk7DQo+ID4gKw0KPiA+ICsJLyogUmVzZXQgZGF0YSBsaW5l
cyBieSBzZXR0aW5nIEVTREhDQ1RMW1JTVERdICovDQo+ID4gKwlzZGhjaV9yZXNldChob3N0LCBT
REhDSV9SRVNFVF9EQVRBKTsNCj4gPiArCS8qIFdyaXRlIDMyJ2hGRkZGX0ZGRkYgdG8gSVJRU1RB
VCByZWdpc3RlciAqLw0KPiA+ICsJc2RoY2lfd3JpdGVsKGhvc3QsIDB4RkZGRkZGRkYsIFNESENJ
X0lOVF9TVEFUVVMpOw0KPiA+ICsNCj4gPiArCS8qIElmIFRCU1RBVFsxNTo4XS1UQlNUQVRbNzow
XSA+IDQgKiBkaXZfcmF0aW8NCj4gPiArCSAqIG9yIFRCU1RBVFs3OjBdLVRCU1RBVFsxNTo4XSA+
IDQgKiBkaXZfcmF0aW8sDQo+ID4gKwkgKiB0aGVuIHByb2dyYW0gVEJQVFJbVEJfV05EV19FTkRf
UFRSXSA9IDQgKiBkaXZfcmF0aW8NCj4gPiArCSAqIGFuZCBwcm9ncmFtIFRCUFRSW1RCX1dORFdf
U1RBUlRfUFRSXSA9IDggKiBkaXZfcmF0aW8uDQo+ID4gKwkgKi8NCj4gPiArCXRic3RhdF83XzAg
PSB2YWwgJiAweGZmOw0KPiA+ICsJdGJzdGF0XzE1XzggPSAodmFsID4+IDgpICYgMHhmZjsNCj4g
PiArDQo+ID4gKwlpZiAoYWJzKHRic3RhdF8xNV84IC0gdGJzdGF0XzdfMCkgPiAoNCAqIGVzZGhj
LT5kaXZfcmF0aW8pKSB7DQo+ID4gKwkJKndpbmRvd19zdGFydCA9IDggKiBlc2RoYy0+ZGl2X3Jh
dGlvOw0KPiA+ICsJCSp3aW5kb3dfZW5kID0gNCAqIGVzZGhjLT5kaXZfcmF0aW87DQo+ID4gKwl9
IGVsc2Ugew0KPiA+ICsJCSp3aW5kb3dfc3RhcnQgPSA1ICogZXNkaGMtPmRpdl9yYXRpbzsNCj4g
PiArCQkqd2luZG93X2VuZCA9IDMgKiBlc2RoYy0+ZGl2X3JhdGlvOw0KPiA+ICsJfQ0KPiA+ICt9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGVzZGhjX2V4ZWN1dGVfc3dfdHVuaW5nKHN0cnVjdCBt
bWNfaG9zdCAqbW1jLCB1MzIgb3Bjb2RlLA0KPiA+ICsJCQkJICAgdTggd2luZG93X3N0YXJ0LCB1
OCB3aW5kb3dfZW5kKSB7DQo+ID4gKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IG1tY19wcml2
KG1tYyk7DQo+ID4gKwlzdHJ1Y3Qgc2RoY2lfcGx0Zm1faG9zdCAqcGx0Zm1faG9zdCA9IHNkaGNp
X3ByaXYoaG9zdCk7DQo+ID4gKwlzdHJ1Y3Qgc2RoY2lfZXNkaGMgKmVzZGhjID0gc2RoY2lfcGx0
Zm1fcHJpdihwbHRmbV9ob3N0KTsNCj4gPiArCXUzMiB2YWw7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArCS8qIFByb2dyYW0gVEJQVFJbVEJfV05EV19FTkRfUFRSXSBhbmQNCj4gVEJQVFJb
VEJfV05EV19TVEFSVF9QVFJdICovDQo+ID4gKwl2YWwgPSAoKHUzMil3aW5kb3dfc3RhcnQgPDwg
RVNESENfV05EV19TVFJUX1BUUl9TSElGVCkgJg0KPiA+ICsJICAgICAgRVNESENfV05EV19TVFJU
X1BUUl9NQVNLOw0KPiA+ICsJdmFsIHw9IHdpbmRvd19lbmQgJiBFU0RIQ19XTkRXX0VORF9QVFJf
TUFTSzsNCj4gPiArCXNkaGNpX3dyaXRlbChob3N0LCB2YWwsIEVTREhDX1RCUFRSKTsNCj4gPiAr
DQo+ID4gKwkvKiBQcm9ncmFtIHRoZSBzb2Z0d2FyZSB0dW5pbmcgbW9kZSBieSBzZXR0aW5nIFRC
Q1RMW1RCX01PREVdPTInaDMNCj4gKi8NCj4gPiArCXZhbCA9IHNkaGNpX3JlYWRsKGhvc3QsIEVT
REhDX1RCQ1RMKTsNCj4gPiArCXZhbCAmPSB+RVNESENfVEJfTU9ERV9NQVNLOw0KPiA+ICsJdmFs
IHw9IEVTREhDX1RCX01PREVfU1c7DQo+ID4gKwlzZGhjaV93cml0ZWwoaG9zdCwgdmFsLCBFU0RI
Q19UQkNUTCk7DQo+ID4gKw0KPiA+ICsJZXNkaGMtPmluX3N3X3R1bmluZyA9IHRydWU7DQo+ID4g
KwlyZXQgPSBzZGhjaV9leGVjdXRlX3R1bmluZyhtbWMsIG9wY29kZSk7DQo+ID4gKwllc2RoYy0+
aW5fc3dfdHVuaW5nID0gZmFsc2U7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0K
PiA+ICBzdGF0aWMgaW50IGVzZGhjX2V4ZWN1dGVfdHVuaW5nKHN0cnVjdCBtbWNfaG9zdCAqbW1j
LCB1MzIgb3Bjb2RlKSAgew0KPiA+ICAJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBtbWNfcHJp
dihtbWMpOw0KPiA+ICAJc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhj
aV9wcml2KGhvc3QpOw0KPiA+ICAJc3RydWN0IHNkaGNpX2VzZGhjICplc2RoYyA9IHNkaGNpX3Bs
dGZtX3ByaXYocGx0Zm1faG9zdCk7DQo+ID4gKwl1OCB3aW5kb3dfc3RhcnQsIHdpbmRvd19lbmQ7
DQo+ID4gKwlpbnQgcmV0LCByZXRyaWVzID0gMTsNCj4gPiAgCWJvb2wgaHM0MDBfdHVuaW5nOw0K
PiA+ICAJdW5zaWduZWQgaW50IGNsazsNCj4gPiAgCXUzMiB2YWw7DQo+ID4gLQlpbnQgcmV0Ow0K
PiA+DQo+ID4gIAkvKiBGb3IgdHVuaW5nIG1vZGUsIHRoZSBzZCBjbG9jayBkaXZpc29yIHZhbHVl
DQo+ID4gIAkgKiBtdXN0IGJlIGxhcmdlciB0aGFuIDMgYWNjb3JkaW5nIHRvIHJlZmVyZW5jZSBt
YW51YWwuDQo+ID4gQEAgLTg3MywzOSArOTYyLDczIEBAIHN0YXRpYyBpbnQgZXNkaGNfZXhlY3V0
ZV90dW5pbmcoc3RydWN0IG1tY19ob3N0DQo+ICptbWMsIHUzMiBvcGNvZGUpDQo+ID4gIAlpZiAo
aG9zdC0+Y2xvY2sgPiBjbGspDQo+ID4gIAkJZXNkaGNfb2Zfc2V0X2Nsb2NrKGhvc3QsIGNsayk7
DQo+ID4NCj4gPiAtCWlmIChlc2RoYy0+cXVpcmtfbGltaXRlZF9jbGtfZGl2aXNpb24gJiYNCj4g
PiAtCSAgICBob3N0LT5mbGFncyAmIFNESENJX0hTNDAwX1RVTklORykNCj4gPiAtCQllc2RoY19v
Zl9zZXRfY2xvY2soaG9zdCwgaG9zdC0+Y2xvY2spOw0KPiA+IC0NCj4gPiAgCWVzZGhjX3R1bmlu
Z19ibG9ja19lbmFibGUoaG9zdCwgdHJ1ZSk7DQo+ID4NCj4gPiAgCWhzNDAwX3R1bmluZyA9IGhv
c3QtPmZsYWdzICYgU0RIQ0lfSFM0MDBfVFVOSU5HOw0KPiA+IC0JcmV0ID0gc2RoY2lfZXhlY3V0
ZV90dW5pbmcobW1jLCBvcGNvZGUpOw0KPiA+DQo+ID4gLQlpZiAoaHM0MDBfdHVuaW5nKSB7DQo+
ID4gLQkJdmFsID0gc2RoY2lfcmVhZGwoaG9zdCwgRVNESENfU0RUSU1OR0NUTCk7DQo+ID4gLQkJ
dmFsIHw9IEVTREhDX0ZMV19DVExfQkc7DQo+ID4gLQkJc2RoY2lfd3JpdGVsKGhvc3QsIHZhbCwg
RVNESENfU0RUSU1OR0NUTCk7DQo+ID4gLQl9DQo+ID4gKwlkbyB7DQo+ID4gKwkJaWYgKGVzZGhj
LT5xdWlya19saW1pdGVkX2Nsa19kaXZpc2lvbiAmJg0KPiA+ICsJCSAgICBoczQwMF90dW5pbmcp
DQo+ID4gKwkJCWVzZGhjX29mX3NldF9jbG9jayhob3N0LCBob3N0LT5jbG9jayk7DQo+ID4NCj4g
PiAtCWlmIChob3N0LT50dW5pbmdfZXJyID09IC1FQUdBSU4gJiYgZXNkaGMtPnF1aXJrX2ZpeHVw
X3R1bmluZykgew0KPiA+ICsJCS8qIERvIEhXIHR1bmluZyAqLw0KPiA+ICsJCXZhbCA9IHNkaGNp
X3JlYWRsKGhvc3QsIEVTREhDX1RCQ1RMKTsNCj4gPiArCQl2YWwgJj0gfkVTREhDX1RCX01PREVf
TUFTSzsNCj4gPiArCQl2YWwgfD0gRVNESENfVEJfTU9ERV8zOw0KPiA+ICsJCXNkaGNpX3dyaXRl
bChob3N0LCB2YWwsIEVTREhDX1RCQ1RMKTsNCj4gPg0KPiA+IC0JCS8qIHByb2dyYW0gVEJQVFJb
VEJfV05EV19FTkRfUFRSXSA9IDMqRElWX1JBVElPIGFuZA0KPiA+IC0JCSAqIHByb2dyYW0gVEJQ
VFJbVEJfV05EV19TVEFSVF9QVFJdID0gNSpESVZfUkFUSU8NCj4gPiAtCQkgKi8NCj4gPiAtCQl2
YWwgPSBzZGhjaV9yZWFkbChob3N0LCBFU0RIQ19UQlBUUik7DQo+ID4gLQkJdmFsID0gKHZhbCAm
IH4oKDB4N2YgPDwgOCkgfCAweDdmKSkgfA0KPiA+IC0JCSgzICogZXNkaGMtPmRpdl9yYXRpbykg
fCAoKDUgKiBlc2RoYy0+ZGl2X3JhdGlvKSA8PCA4KTsNCj4gPiAtCQlzZGhjaV93cml0ZWwoaG9z
dCwgdmFsLCBFU0RIQ19UQlBUUik7DQo+ID4gKwkJcmV0ID0gc2RoY2lfZXhlY3V0ZV90dW5pbmco
bW1jLCBvcGNvZGUpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCWJyZWFrOw0KPiA+DQo+ID4g
LQkJLyogcHJvZ3JhbSB0aGUgc29mdHdhcmUgdHVuaW5nIG1vZGUgYnkgc2V0dGluZw0KPiA+IC0J
CSAqIFRCQ1RMW1RCX01PREVdPTInaDMNCj4gPiArCQkvKiBJZiBIVyB0dW5pbmcgZmFpbHMgYW5k
IHRyaWdnZXJzIGVycmF0dW0sDQo+ID4gKwkJICogdHJ5IHdvcmthcm91bmQuDQo+ID4gIAkJICov
DQo+ID4gLQkJdmFsID0gc2RoY2lfcmVhZGwoaG9zdCwgRVNESENfVEJDVEwpOw0KPiA+IC0JCXZh
bCB8PSAweDM7DQo+ID4gLQkJc2RoY2lfd3JpdGVsKGhvc3QsIHZhbCwgRVNESENfVEJDVEwpOw0K
PiA+IC0JCXNkaGNpX2V4ZWN1dGVfdHVuaW5nKG1tYywgb3Bjb2RlKTsNCj4gPiArCQlyZXQgPSBo
b3N0LT50dW5pbmdfZXJyOw0KPiA+ICsJCWlmIChyZXQgPT0gLUVBR0FJTiAmJg0KPiA+ICsJCSAg
ICAoZXNkaGMtPnF1aXJrX3R1bmluZ19lcnJhdHVtX3R5cGUxIHx8DQo+ID4gKwkJICAgICBlc2Ro
Yy0+cXVpcmtfdHVuaW5nX2VycmF0dW1fdHlwZTIpKSB7DQo+ID4gKwkJCS8qIFJlY292ZXIgSFM0
MDAgdHVuaW5nIGZsYWcgKi8NCj4gPiArCQkJaWYgKGhzNDAwX3R1bmluZykNCj4gPiArCQkJCWhv
c3QtPmZsYWdzIHw9IFNESENJX0hTNDAwX1RVTklORzsNCj4gPiArCQkJcHJfaW5mbygiJXM6IEhv
bGQgb24gdG8gdXNlIGZpeGVkIHNhbXBsaW5nIGNsb2NrLiBUcnkgU1cNCj4gdHVuaW5nIVxuIiwN
Cj4gPiArCQkJCW1tY19ob3N0bmFtZShtbWMpKTsNCj4gPiArCQkJLyogRG8gU1cgdHVuaW5nICov
DQo+ID4gKwkJCWVzZGhjX3ByZXBhcmVfc3dfdHVuaW5nKGhvc3QsICZ3aW5kb3dfc3RhcnQsDQo+
ID4gKwkJCQkJCSZ3aW5kb3dfZW5kKTsNCj4gPiArCQkJcmV0ID0gZXNkaGNfZXhlY3V0ZV9zd190
dW5pbmcobW1jLCBvcGNvZGUsDQo+ID4gKwkJCQkJCSAgICAgIHdpbmRvd19zdGFydCwNCj4gPiAr
CQkJCQkJICAgICAgd2luZG93X2VuZCk7DQo+ID4gKwkJCWlmIChyZXQpDQo+ID4gKwkJCQlicmVh
azsNCj4gPiArDQo+ID4gKwkJCS8qIFJldHJ5IGJvdGggSFcvU1cgdHVuaW5nIHdpdGggcmVkdWNl
ZCBjbG9jay4gKi8NCj4gPiArCQkJcmV0ID0gaG9zdC0+dHVuaW5nX2VycjsNCj4gPiArCQkJaWYg
KHJldCA9PSAtRUFHQUlOICYmIHJldHJpZXMpIHsNCj4gPiArCQkJCS8qIFJlY292ZXIgSFM0MDAg
dHVuaW5nIGZsYWcgKi8NCj4gPiArCQkJCWlmIChoczQwMF90dW5pbmcpDQo+ID4gKwkJCQkJaG9z
dC0+ZmxhZ3MgfD0gU0RIQ0lfSFM0MDBfVFVOSU5HOw0KPiA+ICsNCj4gPiArCQkJCWNsayA9IGhv
c3QtPm1heF9jbGsgLyAoZXNkaGMtPmRpdl9yYXRpbyArIDEpOw0KPiA+ICsJCQkJZXNkaGNfb2Zf
c2V0X2Nsb2NrKGhvc3QsIGNsayk7DQo+ID4gKwkJCQlwcl9pbmZvKCIlczogSG9sZCBvbiB0byB1
c2UgZml4ZWQgc2FtcGxpbmcgY2xvY2suIFRyeQ0KPiB0dW5pbmcgd2l0aCByZWR1Y2VkIGNsb2Nr
IVxuIiwNCj4gPiArCQkJCQltbWNfaG9zdG5hbWUobW1jKSk7DQo+ID4gKwkJCX0gZWxzZSB7DQo+
ID4gKwkJCQlicmVhazsNCj4gPiArCQkJfQ0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCWJyZWFr
Ow0KPiA+ICsJCX0NCj4gPiArCX0gd2hpbGUgKHJldHJpZXMtLSk7DQo+ID4gKw0KPiA+ICsJaWYg
KHJldCkgew0KPiA+ICsJCWVzZGhjX3R1bmluZ19ibG9ja19lbmFibGUoaG9zdCwgZmFsc2UpOw0K
PiA+ICsJfSBlbHNlIGlmIChoczQwMF90dW5pbmcpIHsNCj4gPiArCQl2YWwgPSBzZGhjaV9yZWFk
bChob3N0LCBFU0RIQ19TRFRJTU5HQ1RMKTsNCj4gPiArCQl2YWwgfD0gRVNESENfRkxXX0NUTF9C
RzsNCj4gPiArCQlzZGhjaV93cml0ZWwoaG9zdCwgdmFsLCBFU0RIQ19TRFRJTU5HQ1RMKTsNCj4g
PiAgCX0NCj4gPiArDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtOTM3
LDYgKzEwNjAsMjYgQEAgc3RhdGljIHUzMiBlc2RoY19pcnEoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QsIHUzMg0KPiBpbnRtYXNrKQ0KPiA+ICAJcmV0dXJuIGludG1hc2s7DQo+ID4gIH0NCj4gPg0K
PiA+ICt2b2lkIGVzZGhjX3N0YXJ0X3R1bmluZyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkgew0K
PiA+ICsJc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhjaV9wcml2KGhv
c3QpOw0KPiA+ICsJc3RydWN0IHNkaGNpX2VzZGhjICplc2RoYyA9IHNkaGNpX3BsdGZtX3ByaXYo
cGx0Zm1faG9zdCk7DQo+ID4gKwl1MTYgY3RybDsNCj4gPiArDQo+ID4gKwljdHJsID0gc2RoY2lf
cmVhZHcoaG9zdCwgU0RIQ0lfSE9TVF9DT05UUk9MMik7DQo+ID4gKwljdHJsIHw9IFNESENJX0NU
UkxfRVhFQ19UVU5JTkc7DQo+ID4gKwlzZGhjaV93cml0ZXcoaG9zdCwgY3RybCwgU0RIQ0lfSE9T
VF9DT05UUk9MMik7DQo+ID4gKw0KPiA+ICsJaWYgKGVzZGhjLT5pbl9zd190dW5pbmcpIHsNCj4g
PiArCQl1ZGVsYXkoMSk7DQo+ID4gKwkJY3RybCB8PSBTREhDSV9DVFJMX1RVTkVEX0NMSzsNCj4g
PiArCQlzZGhjaV93cml0ZXcoaG9zdCwgY3RybCwgU0RIQ0lfSE9TVF9DT05UUk9MMik7DQo+IA0K
PiBXaHkgbm90IGRvIHRoYXQgaW4gdGhlIC0+d3JpdGVfdygpIGNhbGxiYWNrIGZvciBTREhDSV9I
T1NUX0NPTlRST0wyDQo+IGluc3RlYWQgb2YgYWRkaW5nIC0+c3RhcnRfdHVuaW5nKCk/DQoNCltZ
LmIuIEx1XSBUaGUgcHVycG9zZSBpcyB0byBzZXQgU0RIQ0lfQ1RSTF9UVU5FRF9DTEsgYml0IGp1
c3QgZm9yIHN0YXJ0aW5nIHR1bmluZy4NCkkgZG9u4oCZdCB0aGluayAtPndyaXRlX3coKSBjb3Vs
ZCBjaGVjayB0aGUgY29uZGl0aW9uIG9mIHN0YXJ0aW5nIHR1bmluZywgd2l0aCBlc2RoYy0+aW5f
c3dfdHVuaW5nIGZsYWcgYW5kIFNESENJX0NUUkxfRVhFQ19UVU5JTkcgYml0IHNldC4NClRoZXJl
IGlzIHBvc3NpYmlsaXR5IFNESENJX0hPU1RfQ09OVFJPTDIgcmVnaXN0ZXIgd2lsbCBiZSB3cml0
dGVuIGZvciBzZXZlcmFsIHRpbWVzIGluIHR1bmluZyBpbiB0aGUgZnV0dXJlLg0KDQpUaGFua3Mu
DQo+IA0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXNkaGNpX3dyaXRlbChob3N0LCBTREhDSV9JTlRf
REFUQV9BVkFJTCwgU0RIQ0lfSU5UX0VOQUJMRSk7DQo+ID4gKwlzZGhjaV93cml0ZWwoaG9zdCwg
U0RIQ0lfSU5UX0RBVEFfQVZBSUwsIFNESENJX1NJR05BTF9FTkFCTEUpOyB9DQo+ID4gKw0KPiA+
ICAjaWZkZWYgQ09ORklHX1BNX1NMRUVQDQo+ID4gIHN0YXRpYyB1MzIgZXNkaGNfcHJvY3RsOw0K
PiA+ICBzdGF0aWMgaW50IGVzZGhjX29mX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSBAQCAt
OTg1LDYgKzExMjgsNyBAQA0KPiA+IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNp
X2VzZGhjX2JlX29wcyA9IHsNCj4gPiAgCS5yZXNldCA9IGVzZGhjX3Jlc2V0LA0KPiA+ICAJLnNl
dF91aHNfc2lnbmFsaW5nID0gZXNkaGNfc2V0X3Voc19zaWduYWxpbmcsDQo+ID4gIAkuaXJxID0g
ZXNkaGNfaXJxLA0KPiA+ICsJLnN0YXJ0X3R1bmluZyA9IGVzZGhjX3N0YXJ0X3R1bmluZywNCj4g
PiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9lc2Ro
Y19sZV9vcHMgPSB7IEBAIC0xMDAzLDYNCj4gPiArMTE0Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgc2RoY2lfb3BzIHNkaGNpX2VzZGhjX2xlX29wcyA9IHsNCj4gPiAgCS5yZXNldCA9IGVzZGhj
X3Jlc2V0LA0KPiA+ICAJLnNldF91aHNfc2lnbmFsaW5nID0gZXNkaGNfc2V0X3Voc19zaWduYWxp
bmcsDQo+ID4gIAkuaXJxID0gZXNkaGNfaXJxLA0KPiA+ICsJLnN0YXJ0X3R1bmluZyA9IGVzZGhj
X3N0YXJ0X3R1bmluZywNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNk
aGNpX3BsdGZtX2RhdGEgc2RoY2lfZXNkaGNfYmVfcGRhdGEgPSB7IEBADQo+ID4gLTExNDAsMTAg
KzEyODUsMTUgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4NCj4gPiAgCXBsdGZtX2hvc3QgPSBzZGhjaV9wcml2KGhv
c3QpOw0KPiA+ICAJZXNkaGMgPSBzZGhjaV9wbHRmbV9wcml2KHBsdGZtX2hvc3QpOw0KPiA+IC0J
aWYgKHNvY19kZXZpY2VfbWF0Y2goc29jX2ZpeHVwX3R1bmluZykpDQo+ID4gLQkJZXNkaGMtPnF1
aXJrX2ZpeHVwX3R1bmluZyA9IHRydWU7DQo+ID4gKwlpZiAoc29jX2RldmljZV9tYXRjaChzb2Nf
dHVuaW5nX2VycmF0dW1fdHlwZTEpKQ0KPiA+ICsJCWVzZGhjLT5xdWlya190dW5pbmdfZXJyYXR1
bV90eXBlMSA9IHRydWU7DQo+ID4gKwllbHNlDQo+ID4gKwkJZXNkaGMtPnF1aXJrX3R1bmluZ19l
cnJhdHVtX3R5cGUxID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsJaWYgKHNvY19kZXZpY2VfbWF0Y2go
c29jX3R1bmluZ19lcnJhdHVtX3R5cGUyKSkNCj4gPiArCQllc2RoYy0+cXVpcmtfdHVuaW5nX2Vy
cmF0dW1fdHlwZTIgPSB0cnVlOw0KPiA+ICAJZWxzZQ0KPiA+IC0JCWVzZGhjLT5xdWlya19maXh1
cF90dW5pbmcgPSBmYWxzZTsNCj4gPiArCQllc2RoYy0+cXVpcmtfdHVuaW5nX2VycmF0dW1fdHlw
ZTIgPSBmYWxzZTsNCj4gPg0KPiA+ICAJaWYgKGVzZGhjLT52ZW5kb3JfdmVyID09IFZFTkRPUl9W
XzIyKQ0KPiA+ICAJCWhvc3QtPnF1aXJrczIgfD0gU0RIQ0lfUVVJUksyX0hPU1RfTk9fQ01EMjM7
DQo+ID4NCg0K
