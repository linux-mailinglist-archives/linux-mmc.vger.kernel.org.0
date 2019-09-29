Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670DEC1463
	for <lists+linux-mmc@lfdr.de>; Sun, 29 Sep 2019 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfI2L5z (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 29 Sep 2019 07:57:55 -0400
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:48951
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfI2L5z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 29 Sep 2019 07:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QILLaEOmlkEH+1sJ3LeiGNWr78s6Ar/qH8iQDpiBR+hFkG6OdBA1esv6dVeAUZbcwRiIW1idnL3D4HPyMkhmDoH26W3VB85vMtwZhIcSbC2PodU0e0exkbK32pQKRbQMqPxm3gGkPp2GdwtQukXWTOIZYUEEqCmn3bqCqceWysMGvooXWwgihuYFkPGmdSWn/Hoqn0oCi98v0XLzmwLGZwqD67SP+L2yjElrJs3nqc9oP8tjPsZsjbIdhOhWet1SDOJo591th6Nues3FrT5GG84fBKSUYd1yNkBPvbVAfIjXOxq/Aq95vnNPqoYtRcl2W6dcXYccRdf8FpChP3+zWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpkbLoUhE/6ExW1F4VoDXvntQw+PC6MG0mWsL8JqQI4=;
 b=cT288xweLhlAw/DOq5rU14z4p796e4xAToIPmtv14EwLRT1zvJ6xBbF/Mbw7j0MFKDPi6/X6KGWjQxjKECU/KLoBlb/JqhoavMyf22yKiqOhQP1FWu2PreqOxkcC1sO/12z7c7HZt87lOqpNcCAaig9/jx5XLfIedHgAUmtEOT/5k7Rxzq/Brh50cXODnqsdwDQ3LpHAsK3bexWqngQPK67SZtSPQc7ahwaGEtaUFbPuls2uXcxjUWePA2GaOyAq+R5SlXpMCryWaRNl3n9FMw2MJbHy16nh3uaEVEFmv6ioI3cT0jspZWMDooJi1g8/M4jYnIE8NYHyRXxcMT04Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpkbLoUhE/6ExW1F4VoDXvntQw+PC6MG0mWsL8JqQI4=;
 b=qHrbITS9IkUy/5NJiAwCZPkXduXThDODC9B7w91XXWPy/BevzXffE+GNz5cBT4qJXlTZTpNsNJtZ3sNoEdTZ65J7SRGVi6X3FbwSpBJyXmQKPnhDyl2JHNchpk0uWvvFFo5mNbh3peqUDdIfVK9SbXSWSXN1fmTqdBldL9SOfwE=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2448.eurprd04.prod.outlook.com (10.168.63.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Sun, 29 Sep 2019 11:57:50 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::dd4c:8b3a:db0a:a483]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::dd4c:8b3a:db0a:a483%8]) with mapi id 15.20.2305.017; Sun, 29 Sep 2019
 11:57:50 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [v2, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
Thread-Topic: [v2, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171
 workaround
Thread-Index: AQHVcrqqSNAH4uJFHUezsKVkwSho5KdClKSQ
Date:   Sun, 29 Sep 2019 11:57:50 +0000
Message-ID: <VI1PR0401MB22376B3627734E21A763AE22F8830@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20190924093131.17471-1-yangbo.lu@nxp.com>
In-Reply-To: <20190924093131.17471-1-yangbo.lu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d28b0819-9ba2-4b2e-72d6-08d744d440d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0401MB2448;
x-ms-traffictypediagnostic: VI1PR0401MB2448:|VI1PR0401MB2448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2448233D082BE6CBE1219584F8830@VI1PR0401MB2448.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 017589626D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39840400004)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(13464003)(71190400001)(25786009)(9686003)(71200400001)(256004)(86362001)(229853002)(66066001)(6436002)(99286004)(4744005)(55016002)(316002)(478600001)(110136005)(66946007)(66476007)(66556008)(64756008)(66446008)(6506007)(53546011)(76116006)(102836004)(2906002)(476003)(26005)(8676002)(76176011)(2501003)(8936002)(5660300002)(6116002)(3846002)(6246003)(7696005)(81156014)(52536014)(186003)(7736002)(74316002)(486006)(14454004)(11346002)(305945005)(446003)(81166006)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2448;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K/KYBrBXr+Rx5I3l8IWP5zbHdUwGHmC7pFkBC2IDoskljMD/Lpf/X3tK8fjZmNbwfHhOLvSAouilixI/uVXXpKYu6GHpGIHXoktRFmAhJioWonV5+rxiX9AhoqDJIvZtymWSieaaCHILLU4B8u3PypepVbTnCFO8la9C8+8L56Yd79NgunkPEMzhCdJpYLf8ZS4ZcuObuPeIpJ7WUpW76WKO0M3Fo7nhc6LWDVVZ+CtN5DER8LI5CbYrN7UvS/1kUOiKRg8Xz+oY6UIsxwnTZXpn3DfQ4vp5or7E7VKPkJ9w0ccQYShK6peuKFaF9nlk0KcnQMKB3so50RcsnWl/BaB9dSYZj2UVevBWnctqM8Salhp4chSioIVXwAJZSMLMZKwF7dm7/CrHLEIXTcd+0P24UEx+YF2kKV0cSyuljts=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28b0819-9ba2-4b2e-72d6-08d744d440d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2019 11:57:50.6214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXZeG+HNXf4gfDdjo1R0tfkgJ9ZeqVFtwnVf+gN63hkz4LuYGWbvf2u3G65YckNx6qYe06aK3Q/NSc02q6ECAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2448
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Any comments on the new version?
Thanks :)

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Yangbo Lu <yangbo.lu@nxp.com>
> Sent: Tuesday, September 24, 2019 5:31 PM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>; Adri=
an
> Hunter <adrian.hunter@intel.com>
> Cc: Y.b. Lu <yangbo.lu@nxp.com>
> Subject: [v2, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171 workaroun=
d
>=20
> This patch-set is to fix up erratum A-008171 workaround. It had been veri=
fied
> on LS1046A eSDHC + Phison 32G eMMC which could trigger the erratum.
> ---
> Changes for v2:
> 	- Dropped sdhci start_tuning() hook patch.
> 	- Implemented SW tuning starting in eSDHC writew().
>=20
> Yangbo Lu (2):
>   mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
>   mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
>=20
>  drivers/mmc/host/sdhci-esdhc.h    |  14 +++
>  drivers/mmc/host/sdhci-of-esdhc.c | 254
> +++++++++++++++++++++++++++++++++-----
>  2 files changed, 235 insertions(+), 33 deletions(-)
>=20
> --
> 2.7.4

