Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5BBACE2
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406015AbfIWDeg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 22 Sep 2019 23:34:36 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:49496
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404054AbfIWDeg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 22 Sep 2019 23:34:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk5SxNBZ4W/8PgS92LX3o2OFUs4Qj/i/KSaTtykbbtW+2XDjGrHfrCJorVmiSIxswvZWNjTv4FAjEYNF9m287ZlH+BOHtEvwViAqwx/3pNaW1plzvHChmOt0JmqsgPSu4ztZcICTrFJvzmb7p3M6ihsbKxXe6F18hDxENk4+vmK8G8UFgzQA32YOkkGDKre9ZMdKInVr529qxzisJUwNdqxe7t9tyTbWIVTePvTZ5EQqHdhEN7219UKGZlTiCQa/59ddBD7eg95K2fWa/6eGPT5Lh83uXenJc1AmcVxzsv3oJrXWu/rmawu75jOltdkkHVxJ+ORxmgYUEwZRXBhw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxOUI9x4EiYJa5P4flD+vKUnXLAQaatq71HgXzMTI50=;
 b=ArY+s8ZlfoCRFqlVle4sxb2EdirTxIzq9O4Ctlu3b8OUNfq0tHfLbenprPtlZcuzHplt5UkSEpPpti4KnYnC04/5M4lB0RDbZL/Eq6bTFYhIw4ejXHCh/rxGmMU4V7pBj3jh/33845BlL+I91IcLPmXd4Ir953WEEHvEhd6v1+b2q7+L3ai/aOy0gZKMwFluUD0DBQUDgxk/AXIbz4YCD8PEEqHowEjj/BzUxjmHEqsVUpKxWFXGiOHximjhae5e+5MVd/GDrvS7teQAQapSOLhQxFvzfh+o2O/lafDe0QQsSpxcp8KVo1ROdEU012JTLtzpXCnWHcgQ3zIjJbYWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxOUI9x4EiYJa5P4flD+vKUnXLAQaatq71HgXzMTI50=;
 b=sihuUYAww0k5AcBofODBZUsfYo4Im9A+pzx1GZtBbGUdiYMWSYdYw1LYU973hu8cRdfXhXP84GFVKrcVjqOdjou42EI+M83cjATZWeo63zobOXDij4ktIEzjfL8Cq/uZrOCd6UpqRfkS639vj77Ktjo/0jv4/haGo2DST2tiih0=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2638.eurprd04.prod.outlook.com (10.168.65.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 03:34:32 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::40fb:b35c:722a:101f]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::40fb:b35c:722a:101f%10]) with mapi id 15.20.2284.023; Mon, 23 Sep
 2019 03:34:32 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [PATCH 0/3] mmc: sdhci-of-esdhc: fix up erratum A-008171
 workaround
Thread-Topic: [PATCH 0/3] mmc: sdhci-of-esdhc: fix up erratum A-008171
 workaround
Thread-Index: AQHVbRKr9nYXX9/R10K1bDu08bs63Kc4pVvA
Date:   Mon, 23 Sep 2019 03:34:32 +0000
Message-ID: <VI1PR0401MB22374C1326E5964E76913F79F8850@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20190917044631.3161-1-yangbo.lu@nxp.com>
In-Reply-To: <20190917044631.3161-1-yangbo.lu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cec871e-d3b4-4d36-3af6-08d73fd6f2b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0401MB2638;
x-ms-traffictypediagnostic: VI1PR0401MB2638:|VI1PR0401MB2638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB263860861CAB8929EE48276FF8850@VI1PR0401MB2638.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(13464003)(189003)(199004)(305945005)(7736002)(2906002)(52536014)(76116006)(66476007)(229853002)(64756008)(3846002)(6116002)(86362001)(4744005)(66446008)(33656002)(14454004)(256004)(25786009)(5660300002)(66946007)(110136005)(478600001)(66556008)(66066001)(446003)(476003)(316002)(11346002)(71190400001)(55016002)(8936002)(99286004)(71200400001)(486006)(9686003)(6246003)(2501003)(53546011)(6506007)(81156014)(81166006)(186003)(7696005)(26005)(6436002)(74316002)(76176011)(102836004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2638;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UJSmmwu0+MVwKAUrdIDPGAnVgeOEW0qXvkbmlYlyPe2HThC10A6oRd7P0TfvIcFO4r+TFj1crtifgl6p8bTxypifDvemXCOL/ouSStXiLeIFpSsJVsRR7WcFSVNWiGgOv81vxbQCyyEPt2Wka3dfKbvZMSEGb1+XoshDpG5R/q/aa94twtH04Sj6wFRn7eLGcVvt3kvMn2VyBXqorOMvJSB/zwXy/BukzPiHtLxG7PAMvQi2ji7knbQHYJ5QmkBCFNboCehk/Mfr0oVAR1E4Q/p7r42TpFp9fD4xDfxVYDVWQ2E5ZZAlaAQwkjWSgova4EnCDIlDNUbvfLNPvzgd5SL9JBKOBZKXU55+iJlE1bZM6/pYIr+Lq2QNdxHWTAma6HoDKvE7kwiRaYqz1yK/7a5Hx0mOk19WLfK8YuskLuA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cec871e-d3b4-4d36-3af6-08d73fd6f2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 03:34:32.2990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9mh7sZ+BNdNuh1FyU55eZqcLlbJdWSWmH3U7mwOyDSD0LZxyS0oPBuMyqqK4vLGkoegpAknH40e8teu4KCakQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2638
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Any comments?
Thanks :)

> -----Original Message-----
> From: Yangbo Lu <yangbo.lu@nxp.com>
> Sent: Tuesday, September 17, 2019 12:46 PM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>; Adri=
an
> Hunter <adrian.hunter@intel.com>
> Cc: Y.b. Lu <yangbo.lu@nxp.com>
> Subject: [PATCH 0/3] mmc: sdhci-of-esdhc: fix up erratum A-008171
> workaround
>=20
> This patch-set is to fix up erratum A-008171 workaround. It had been veri=
fied
> on LS1046A eSDHC + Phison 32G eMMC which could trigger the erratum.
>=20
> Yangbo Lu (3):
>   mmc: sdhci: introduce start_tuning() hook
>   mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
>   mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
>=20
>  drivers/mmc/host/sdhci-esdhc.h    |   9 ++
>  drivers/mmc/host/sdhci-of-esdhc.c | 248
> +++++++++++++++++++++++++++++++++-----
>  drivers/mmc/host/sdhci.c          |   5 +-
>  drivers/mmc/host/sdhci.h          |   1 +
>  4 files changed, 229 insertions(+), 34 deletions(-)
>=20
> --
> 2.7.4

