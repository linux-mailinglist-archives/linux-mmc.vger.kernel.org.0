Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC01DA69
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 04:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfD2CP1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 28 Apr 2019 22:15:27 -0400
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:36190
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfD2CP0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 28 Apr 2019 22:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myn9lQ4vMe41+UNLrtO6TlG5nrm615FwW9VyduQYtvk=;
 b=mZAvs+yAV1lmu8zId1HXBeEU2EEG6tK6c9ZKNSHadZMwTrqae0EgPJpy/72PzJavY3rq0eA8QbGz+O9pnr8wI4C6f7ZHF6Hy6K5xGjPRyuR51IofNyhfL+ORQQZY1PkPCtX3AZovERvMzW5i5CjIgtVt0R8YHa/6lDfwC8BvD5E=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6068.eurprd04.prod.outlook.com (20.179.34.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 02:15:23 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 02:15:23 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     BOUGH CHEN <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx7ulp
 compatible string
Thread-Topic: [PATCH 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx7ulp
 compatible string
Thread-Index: AQHU/Zsi9HaxPthgtUmGrGw0Is/2nqZSZ2Ug
Date:   Mon, 29 Apr 2019 02:15:23 +0000
Message-ID: <AM0PR04MB421197C7B6280417B466ABAB80390@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190428082727.3419-1-haibo.chen@nxp.com>
In-Reply-To: <20190428082727.3419-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ca1924-51bf-4019-6f30-08d6cc488966
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6068;
x-ms-traffictypediagnostic: AM0PR04MB6068:
x-microsoft-antispam-prvs: <AM0PR04MB60681785F35FBAA096266CCD80390@AM0PR04MB6068.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(25786009)(478600001)(3846002)(33656002)(558084003)(71200400001)(71190400001)(8936002)(81156014)(81166006)(8676002)(5660300002)(26005)(186003)(7736002)(4326008)(76176011)(6506007)(7696005)(102836004)(11346002)(446003)(14454004)(6246003)(44832011)(476003)(486006)(74316002)(52536014)(66066001)(305945005)(99286004)(97736004)(53936002)(2201001)(86362001)(55016002)(2906002)(6436002)(9686003)(229853002)(66446008)(2501003)(76116006)(66476007)(256004)(6116002)(64756008)(66556008)(73956011)(316002)(66946007)(54906003)(110136005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6068;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Feb/f7ftYaq4MVz3OZS+DKvN9EnovOxpNtwMVPvlcShW+ArVsGvO1sI18FabmWkSmY6qRPNAB5Sdiv1NZZ2kEKwna97ARu9J+b3QRIaglhp65p6Icj/1PcQIXRCckng7GunaEPbwh+lTmFmDp6BpUAE6TbHO+XBprQA7SokMxecVCeljS4WnHqineKR7yTVhCFIeI4mt0mLbC22Tbz5w07u7b5amlaDlzWDcuHODweAyy48J0+RCJeCnbxsxrpE/UNUljvJuweVByNBAR1GNOfofXkbYSAz8onmZVf1TI2dO5WGsvDusPXE+qJ7QyiItPYoCGJyYQVsnhjjYWemhZiyIetX7QegJta3Rxf/adUqJH+oy6LLSrVr50bPS4Q8Uaie0XCjMFdsIuq8+lPELVpwu5/e+8nRQqYbU1j4Niw8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ca1924-51bf-4019-6f30-08d6cc488966
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 02:15:23.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6068
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBGcm9tOiBCT1VHSCBDSEVODQo+IFNlbnQ6IFN1bmRheSwgQXByaWwgMjgsIDIwMTkgNDoyMCBQ
TQ0KPiANCj4gQWRkIGlteDd1bHAgY29tcGF0aWJsZSBzdHJpbmcuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25n
IEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcN
Cg==
