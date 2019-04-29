Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FBAE089
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 12:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfD2K3Z (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 06:29:25 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:25248
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727621AbfD2K3Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Apr 2019 06:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpMilQj4b9p+dnnDYSWZx4aQfoihZGWFwIEmbPIiRBA=;
 b=AciLVc5nQrTfCL5eElS1ghsHWXVqzpoeSvxbWCb5dw1Fp4qpJI+RkOvYf+MF64VFeiRcL32k1roE3GFtjrag32EDaoAiDlKnBU91MGJPWDFwPWMyEwiutMV2DvGU7tV2cLIz7IJlT1TzrBMgsHRq7rAHv5tZmLSdZvFpPgzWmVo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6370.eurprd04.prod.outlook.com (20.179.252.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 10:29:21 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 10:29:21 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     BOUGH CHEN <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] mmc: add HS400 support for iMX7ULP
Thread-Topic: [PATCH v2 3/3] mmc: add HS400 support for iMX7ULP
Thread-Index: AQHU/mlUf3sxsYJzT0KMntSB9hvhNqZS7ssQ
Date:   Mon, 29 Apr 2019 10:29:21 +0000
Message-ID: <AM0PR04MB42116553966D9E00C09D382A80390@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190429090310.25484-1-haibo.chen@nxp.com>
 <20190429090310.25484-4-haibo.chen@nxp.com>
In-Reply-To: <20190429090310.25484-4-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8421d778-795c-4834-c9f1-08d6cc8d8b3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6370;
x-ms-traffictypediagnostic: AM0PR04MB6370:
x-microsoft-antispam-prvs: <AM0PR04MB637063571847377928119D9480390@AM0PR04MB6370.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(4326008)(86362001)(76176011)(5660300002)(99286004)(25786009)(81156014)(8676002)(81166006)(186003)(11346002)(8936002)(4744005)(7696005)(256004)(14444005)(476003)(14454004)(54906003)(6246003)(316002)(33656002)(97736004)(229853002)(53936002)(2201001)(6436002)(68736007)(110136005)(52536014)(9686003)(73956011)(2501003)(74316002)(55016002)(44832011)(6506007)(102836004)(2906002)(53546011)(6116002)(71200400001)(66066001)(486006)(26005)(3846002)(66446008)(64756008)(66556008)(66476007)(66946007)(305945005)(7736002)(71190400001)(478600001)(446003)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6370;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oJT91+lsikSfqEs1kvQVx3xBO0JVvN+BBfdYXWLRP1sRjYtbX/zIXAs+k51votVPpvPaix89+1rJwLoApBl2yv3RsNvtW24wKnWqokT7samQq0AulJJ1jRxQkH0/QBoxb7IFP88yhhIEtJkQxCMJdplBvqsxWkO4KdP7B27PYRJ/pp/6AJsLqXY6/8k433O04eI9JNS5PvNqeaXq8FIIiJ8s8sQzOz1fkY42BPSf/YdHl9KGBAG1ffka754Hn//YvaK0Pm+F7+o8AZh/BtZiJohM4hnIGiJUcpvLEP3v0D8bWdIVg1PCP7+JWpWQrI1t5GvZ2WSihbwacvsbOYKQ4Q+5TBBwUPcOA9DTApKYA+LZ4R1+cHgU6NrygAwlzZ6JTyH7bNiyfE+oTkgiuQURktTU2rZJA6s5dwc7H0nxgsM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8421d778-795c-4834-c9f1-08d6cc8d8b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 10:29:21.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6370
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBGcm9tOiBCT1VHSCBDSEVODQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjksIDIwMTkgNDo1NiBQ
TQ0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMy8zXSBtbWM6IGFkZCBIUzQwMCBzdXBwb3J0IGZvciBp
TVg3VUxQDQo+IA0KPiBBZGQgSFM0MDAgc3VwcG9ydCBmb3IgaU1YN1VMUCBCMC4NCj4gDQo+IEFj
Y29yZGluZyB0byBJQyBzdWdnZXN0LCBuZWVkIHRvIGNsZWFyIHRoZSBTVFJPQkVfRExMX0NUUkxf
UkVTRVQgYmVmb3JlIGFueQ0KPiBzZXR0aW5nIG9mIFNUUk9CRV9ETExfQ1RSTCByZWdpc3Rlci4N
Cj4gDQo+IFVTREhDIGhhcyByZWdpc3RlciBiaXRzKGJpdFsyN34yMF0gb2YgcmVnaXN0ZXIgU1RS
T0JFX0RMTF9DVFJMKSBmb3Igc2xhdmUgc2VsDQo+IHZhbHVlLiBJZiB0aGlzIHJlZ2lzdGVyIGJp
dHMgdmFsdWUgaXMgMCwgIGl0IG5lZWRzDQo+IDI1NiByZWZfY2xrIGN5Y2xlcyB0byB1cGRhdGUg
c2xhdmUgc2VsIHZhbHVlLiBJQyBzdWdnZXN0IHRvIHNldCBiaXRbMjd+MjBdIHRvIDB4NCwNCj4g
aXQgb25seSBuZWVkIDQgcmVmX2NsayBjeWNsZSB0byB1cGRhdGUgc2xhdmUgc2VsIHZhbHVlLiBU
aGlzIHdpbGwgc2hvcnQgdGhlIGxvY2sNCj4gdGltZSBvZiBzbGF2ZS4NCj4gDQo+IGkuTVg3VUxQ
IEIwIHdpbGwgbmVlZCBtb3JlIHRpbWUgdG8gbG9jayB0aGUgUkVGIGFuZCBTTFYsIHNvIGNoYW5n
ZSB0byBhZGQNCj4gNXVzIGRlbGF5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KDQptbWM6IHNkaGNpLWVzZGhjLWlteDogYWRkIEhTNDAwIHN1
cHBvcnQgZm9yIGlNWDdVTFANCg0Kb3RoZXJ3aXNlOg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVu
ZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
