Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0885C2C
	for <lists+linux-mmc@lfdr.de>; Thu,  8 Aug 2019 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfHHH4T (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 8 Aug 2019 03:56:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17860 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfHHH4S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2019 03:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565250978; x=1596786978;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=O1Z5d4UwZu0vqmyUwI8Lat0UFnV0YoOLO/dhLZ14yvI=;
  b=MurJ1xUQlhBalRxzKnEGEVu40dFXP1fzAf57fLusmoI9FOp3rVxS4rR4
   tgAzvXI6qj7JROtne/6EM9daF2Jw9RCJ6oTAqQ6qKEXvrV8A/zvJ+krSU
   1HxiW23C59Uhp7CiZc67AqHvnubwpJD0IVtPoQzvh2Zh/YeHhEXJQkUT+
   RkQQL/Q6Io8sqEVp4xf2r6QIty9ppJuHU+rUL/nBWFEkrToZDfYTQHyg3
   /CQkzgsaeUZ3FZp8qeachHxgOficbJmB7dbXskzZLvnoE8TOMjZBLuhpL
   aBKqNstRgnNWDnnfYACd456VcDX5UaRDOC4AlhCyouxCT+jpHu1wNCzeV
   A==;
IronPort-SDR: E3LO2q6ILabAefEfxLmGdinTAkT4gkhXgKeBLY1LV7KgbZe0Az1JGwK63ZXm0MJl+d8BanYiIm
 cnWgzov213CWqUDi+dHluFzcqtQYXv8SJgm0non4IGWZSwp1N2lR+ZziR9NZwLgPotMfPGsoPj
 iOcy0t/Zzs13VFqsfRFn3LYxPF2A5oOb5xPCIqDaR8gQqRRF4+jGRyqEqVUp1WyoizUvEBks8U
 fD07pDzEYPIuy4Dd72LjhkE9fRf2c5dKEz+RYreVwzXaW88rMY182/JOrnVLMVhqC5m4as9Ah4
 WCI=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115356319"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 15:56:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3WMEEuNRf+E9baeFQkdmJj9/EMJn8n+iM/3Z8kazA11sZV27upGNkMod/0HvxoTUOaOKfR2nOp9wAoR1MsTAx9nFhE8qHuy43sd0e7fTBgL+68kqRUSq2oCnrWeUDMek8oumGBlK+x0tog73fXmZ6WXhseIefTadLpRFyNonpor+7Fn57ZUQbQwk99lCh0yfeA30xVunzTOvWNRK+SbQt5E1C8B5mO6HOmXIaoRG7cZh98v6zQ8hi32bcM2OhRj/irkRq9CorGqDs8vzGVxTu9vTWB5W0t7rSd/ej0QFYZWz2XIGTk/ohGyZCbus8GDm6iumpa9ifQMajsT+o+sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1Z5d4UwZu0vqmyUwI8Lat0UFnV0YoOLO/dhLZ14yvI=;
 b=esYB6crs1Tp9K41hNpwGzMEPvV6Ze/gKcGFX1R4w6cJuMjHIgCtl+e5D0+BrCCr00yy7m8oHWM8RxFbcnb+kRgCEhI8AwaRwFBpvhzbOjc27pp4dngt1zKSJnWiMocOobRL/41baMoK3qv4wzvifKU1vMgAcdnPxqfEMjowc8TDnwt+WszdZR/IwHqn9dt/TyOYK6euogDS9TS0Kipm/OkCnhfvEQcc5+tH5eT0PICiit3MwmjztmRc1yBddu99TqsFz7HlXRynDuaECCj7PHz9dM+58ZLpKbKoqWtv9TSdXuIm1hI7e1EIaLpg34HxeYhc7k3OMpW9EK3YisbP5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1Z5d4UwZu0vqmyUwI8Lat0UFnV0YoOLO/dhLZ14yvI=;
 b=MWE52kVPcgK+7vTqiO5+dp8OeljJgT/xYB18f6EezyYCRvRmYuFq58gqy9R3oB06bJpOAWbJFdXxeT+yi0CcGfUL/oyRuCqxz1vTCaVGLAmFMUrFfe+ohFIAhCzwr1hHZmOIpRZWs1rwlTZIVY/ElgnPGodQVPCySm/C0NxYmzA=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5824.namprd04.prod.outlook.com (20.179.21.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Thu, 8 Aug 2019 07:56:16 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5d3b:c35e:a95a:51e2]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5d3b:c35e:a95a:51e2%3]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 07:56:16 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jungseung Lee <js07.lee@samsung.com>,
        Chris Ball <chris@printf.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "js07.lee@gmail.com" <js07.lee@gmail.com>
Subject: RE: [PATCH] mmc-utils: feature spec 5.0+, add secure removal type
 fileds to Extended CSD
Thread-Topic: [PATCH] mmc-utils: feature spec 5.0+, add secure removal type
 fileds to Extended CSD
Thread-Index: AQHVTP/xoJTw0jxH0kan3URloBRdRKbw4VRw
Date:   Thu, 8 Aug 2019 07:56:16 +0000
Message-ID: <MN2PR04MB6991A3254717667019E649C6FCD70@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <CGME20190807091012epcas1p2d949c05b6dafb0a22f6babe13c5ae9c8@epcas1p2.samsung.com>
 <20190807091001.2957-1-js07.lee@samsung.com>
In-Reply-To: <20190807091001.2957-1-js07.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d89d6b1-6a87-4028-95cf-08d71bd5e456
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5824;
x-ms-traffictypediagnostic: MN2PR04MB5824:
x-microsoft-antispam-prvs: <MN2PR04MB5824C645A6BF3E375DD26B08FCD70@MN2PR04MB5824.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(55016002)(7736002)(110136005)(9686003)(99286004)(316002)(81166006)(8676002)(25786009)(81156014)(6436002)(8936002)(229853002)(478600001)(7696005)(53936002)(66556008)(102836004)(76176011)(2201001)(2501003)(6506007)(71190400001)(71200400001)(26005)(5660300002)(186003)(256004)(66066001)(33656002)(3846002)(66476007)(305945005)(74316002)(2906002)(64756008)(52536014)(76116006)(476003)(486006)(66946007)(446003)(14454004)(66446008)(11346002)(86362001)(6116002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5824;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wAxGCzZFev3INftbkwLjsCjPYZvHg7Gu44VX1J+KBCQMd1SBNbtSl/SdiwHbif7xworv8yYJwQnyH8rYWU1jpr04qZCl4YJhXKqdwK/T6FmjwV8MphuuvyWoFnhvzwqJZtnIGRV6oCtN3sFlzKkpom7LIPPx0Z5hguFZY3wwnxdMT6af2BDWN+OlLcqQu0HFRt5lg/UK8Ees44XIEJ4nMa72dLFZ8+wWHe9LimXMM6xJKyan9GGf8GVeNttTqYay+1Y0DCA9OZY7+PDFHYju0JsJs+2XaW9RXgsEZ1ykq3Xz9gM8Ora1dimfGlgoi8giWoCoe4lrFafS0pW7W154tqTBlvZzfJ+EpYYNbSK45iVYrX7oBi/Igwg8dx0UeXR2xij7URDqJUrvgkZ1DjinMJirZexOOGWhMLtLeImDW4g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d89d6b1-6a87-4028-95cf-08d71bd5e456
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 07:56:16.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLm8U96srt0azsYHcbCUwJMl40HKj/N+qid95Mkx6A9+6egdIabM+4tLgeRj3P3qiCntWkTTHNexBqxHMf1gtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5824
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQoNCj4gDQo+IERpc3BsYXkgc2VjdXJlIHJlbW92YWwgdHlwZSB3aGVuIHByaW50aW5nIEV4
dGVuZGVkIENTRA0KPiBFeGFtcGxlOg0KPiAJIyBtbWMgZXh0Y3NkIHJlYWQgL2Rldi9tbWNibGsw
DQo+IAkuLi4NCj4gCVNlY3VyZSBSZW1vdmFsIFR5cGUgW1NFQ1VSRV9SRU1PVkFMX1RZUEVdOiAw
eDM5DQo+IAkgaW5mb3JtYXRpb24gcmVtb3ZlZCB1c2luZyBhIHZlbmRvciBkZWZpbmVkDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKdW5nc2V1bmcgTGVlIDxqczA3LmxlZUBzYW1zdW5nLmNvbT4NCj4g
LS0tDQo+ICBtbWMuaCAgICAgIHwgIDMgKysrDQo+ICBtbWNfY21kcy5jIHwgMTkgKysrKysrKysr
KysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbW1jLmggYi9tbWMuaA0KPiBpbmRleCAyODVjMWYxLi42NDhmYjI2IDEwMDY0
NA0KPiAtLS0gYS9tbWMuaA0KPiArKysgYi9tbWMuaA0KPiBAQCAtMTE2LDYgKzExNiw3IEBADQo+
ICAjZGVmaW5lIEVYVF9DU0RfTU9ERV9DT05GSUcJCTMwDQo+ICAjZGVmaW5lIEVYVF9DU0RfTU9E
RV9PUEVSQVRJT05fQ09ERVMJMjkJLyogVyAqLw0KPiAgI2RlZmluZSBFWFRfQ1NEX0ZGVV9TVEFU
VVMJCTI2CS8qIFIgKi8NCj4gKyNkZWZpbmUgRVhUX0NTRF9TRUNVUkVfUkVNT1ZBTF9UWVBFCTE2
CS8qIFIvVyAqLw0KPiAgI2RlZmluZSBFWFRfQ1NEX0NNRFFfTU9ERV9FTgkJMTUJLyogUi9XICov
DQo+IA0KPiAgLyoNCj4gQEAgLTEzMiw2ICsxMzMsOCBAQA0KPiAgLyoNCj4gICAqIEVYVF9DU0Qg
ZmllbGQgZGVmaW5pdGlvbnMNCj4gICAqLw0KPiArI2RlZmluZSBFWFRfQ1NEX0NPTkZJR19TRUNS
TV9UWVBFCSgweDMwKQ0KPiArI2RlZmluZSBFWFRfQ1NEX1NVUFBPUlRFRF9TRUNSTV9UWVBFCSgw
eDBmKQ0KPiAgI2RlZmluZSBFWFRfQ1NEX0ZGVV9JTlNUQUxMCQkoMHgwMSkNCj4gICNkZWZpbmUg
RVhUX0NTRF9GRlVfTU9ERQkJKDB4MDEpDQo+ICAjZGVmaW5lIEVYVF9DU0RfTk9STUFMX01PREUJ
CSgweDAwKQ0KPiBkaWZmIC0tZ2l0IGEvbW1jX2NtZHMuYyBiL21tY19jbWRzLmMNCj4gaW5kZXgg
MTlhOWRhMS4uOGQ2NDU1ZSAxMDA2NDQNCj4gLS0tIGEvbW1jX2NtZHMuYw0KPiArKysgYi9tbWNf
Y21kcy5jDQo+IEBAIC0xNzY2LDYgKzE3NjYsMjUgQEAgaW50IGRvX3JlYWRfZXh0Y3NkKGludCBu
YXJncywgY2hhciAqKmFyZ3YpDQo+IA0KPiAJZXh0X2NzZFtFWFRfQ1NEX0RFVklDRV9MSUZFX1RJ
TUVfRVNUX1RZUF9CXSk7DQo+ICAJCXByaW50ZigiZU1NQyBQcmUgRU9MIGluZm9ybWF0aW9uDQo+
IFtFWFRfQ1NEX1BSRV9FT0xfSU5GT106IDB4JTAyeFxuIiwNCj4gIAkJCWV4dF9jc2RbRVhUX0NT
RF9QUkVfRU9MX0lORk9dKTsNCj4gKwkJcmVnID0gZXh0X2NzZFtFWFRfQ1NEX1NFQ1VSRV9SRU1P
VkFMX1RZUEVdOw0KPiArCQlwcmludGYoIlNlY3VyZSBSZW1vdmFsIFR5cGUgW1NFQ1VSRV9SRU1P
VkFMX1RZUEVdOg0KPiAweCUwMnhcbiIsIHJlZyk7DQo+ICsJCXByaW50ZigiIGluZm9ybWF0aW9u
IHJlbW92ZWQgIik7DQpwcmludGYoIiBpbmZvcm1hdGlvbiBpcyBjb25maWd1cmVkIHRvIGJlIHJl
bW92ZWQgIik7DQoNCj4gKwkJc3dpdGNoICgocmVnICYgRVhUX0NTRF9DT05GSUdfU0VDUk1fVFlQ
RSkgPj4gNCkgew0KTWF5YmUgYWRkIGFuIGFwcHJvcHJpYXRlIGNvbW1lbnQsIGUuZy4NCi8qIEJp
dCBbNTo0XTogQ29uZmlndXJlIFNlY3VyZSBSZW1vdmFsIFR5cGUgKi8NCg0KPiArCQkJY2FzZSAw
eDA6DQo+ICsJCQkJcHJpbnRmKCJieSBhbiBlcmFzZSBvZiB0aGUgcGh5c2ljYWwNCj4gbWVtb3J5
XG4iKTsNCj4gKwkJCQlicmVhazsNCj4gKwkJCWNhc2UgMHgxOg0KPiArCQkJCXByaW50ZigiYnkg
YW4gb3ZlcndyaXRpbmcgdGhlIGFkZHJlc3NlZA0KPiBsb2NhdGlvbnMiDQo+ICsJCQkJICAgICAg
ICIgd2l0aCBhIGNoYXJhY3RlciBmb2xsb3dlZCBieSBhbg0KPiBlcmFzZVxuIik7DQo+ICsJCQkJ
YnJlYWs7DQo+ICsJCQljYXNlIDB4MjoNCj4gKwkJCQlwcmludGYoImJ5IGFuIG92ZXJ3cml0aW5n
IHRoZSBhZGRyZXNzZWQNCj4gbG9jYXRpb25zIg0KPiArCQkJCSAgICAgICAiIHdpdGggYSBjaGFy
YWN0ZXIsIGl0cyBjb21wbGVtZW50LA0KPiB0aGVuIGEgcmFuZG9tIGNoYXJhY3RlclxuIik7DQo+
ICsJCQkJYnJlYWs7DQo+ICsJCQljYXNlIDB4MzoNCj4gKwkJCQlwcmludGYoInVzaW5nIGEgdmVu
ZG9yIGRlZmluZWRcbiIpOw0KPiArCQkJCWJyZWFrOw0KPiArCQl9DQo+ICAJfQ0KWW91IGZvcmdv
dCB0byBwYXJzZSB0aGUgc3VwcG9ydGVkIHBhcnQgLSBFWFRfQ1NEX1NVUFBPUlRFRF9TRUNSTV9U
WVBFDQoNCg0KVGhhbmtzLA0KQXZyaQ0K
