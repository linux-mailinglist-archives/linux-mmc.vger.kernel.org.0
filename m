Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160D7D85DC
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Oct 2019 04:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfJPCUt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 15 Oct 2019 22:20:49 -0400
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:4931
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfJPCUt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Oct 2019 22:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvElOJ+FABxPrjjE3QNReOrnfv4gxfAYzlnBM4289DndiIGBrXBLqqSfJvf5IFqrS2brwUNM93ipsUfWvhLTuIumgVOKLASjxJxO2YZeuvLgJx+iSxZqRj6SFefxUNdRXKqoDNk2qbB4xAuUQlWukIFqRiVeOyEl6CEG/efrhKH43EXKx4h/2eM9Dj3IBkvZvRmyZZRsqX7A7fXe5zF5q7UIX4Xf7QxWeRsULaj7DafpXh/F2kBOzgS3Sz48BpVebUJG+Ph+zeKHH8KkK2wttTp45IeyKv2sbQVEvlWAwnzo6BO3rWuJ9KgiSuOC/ylDp2LF27GpVJT44LwtXRUy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1L9PXJSrHjc5g/JLshYoPRsV4eTKkhqeU2EDe3tUhI=;
 b=mw/LnFF0+MVNi3oGj86RjM7FPknS6TVDCwtAOeUFlkdjfHhOK80WGVa4XLvqdxT+emFhZek9m44MhwFYq1LtA8AIoISsHlGkAiWVg8rYyI1D1rgWO5CevVtE0hgqa4gdoIASJ6dXGD3rTNq1MlB+RocW2bDLrUKsFatMUWCM+esACRhlvEykiaWF+wZH9C5Wmq7PrQlxSgxAw2H9iqfWU1N/mjDOiDB8qFni2A+mTOFdAPzeozr4SxqZL+oTGbOpWX7i2nDayg4LQShKasVApFcIgn3z3rih+o/WkMrWuuJmFFz/EQsebfnRiFjlHj3zWspYkJG2tOFqQWo668Lbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1L9PXJSrHjc5g/JLshYoPRsV4eTKkhqeU2EDe3tUhI=;
 b=AdcQ/+Xh56ccJDjOYmoyVQ9BfiqCY29e2EJNZoI8MVfSP+1VfR9iG7BjYMzxYM+s7N5+3CkfxOLMDx5It09aE7FjbRKTvdq7WrOB1G93rQznYFnVTCFGGdRPRhDrGUtRmPHLNH9KSATDwM28YrYYsRZFXBL/rI7/IU+uc9VVOnk=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2269.eurprd04.prod.outlook.com (10.169.134.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 02:20:45 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::dd4c:8b3a:db0a:a483]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::dd4c:8b3a:db0a:a483%8]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 02:20:45 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [v3, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
Thread-Topic: [v3, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171
 workaround
Thread-Index: AQHVfnTd6kOfn0JAKkyOdu1OdP8yyqdckvQw
Date:   Wed, 16 Oct 2019 02:20:45 +0000
Message-ID: <VI1PR0401MB223758FFDEA1854BD0AFD810F8920@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20191009074140.3934-1-yangbo.lu@nxp.com>
In-Reply-To: <20191009074140.3934-1-yangbo.lu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b97b5f89-b360-497b-5bec-08d751df73c4
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0401MB2269:
x-microsoft-antispam-prvs: <VI1PR0401MB2269524A8DE8BD04787BF24AF8920@VI1PR0401MB2269.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(199004)(189003)(13464003)(186003)(8936002)(102836004)(81156014)(81166006)(6436002)(9686003)(6246003)(7696005)(52536014)(11346002)(8676002)(6506007)(476003)(66066001)(53546011)(99286004)(26005)(76176011)(446003)(486006)(5660300002)(55016002)(110136005)(256004)(71190400001)(6116002)(86362001)(2906002)(33656002)(74316002)(64756008)(478600001)(316002)(14454004)(25786009)(229853002)(71200400001)(7736002)(3846002)(76116006)(305945005)(66946007)(66446008)(66556008)(66476007)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2269;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ue/qzbo+wyyIXzWE+wepEEAqku/3EBYRsyqoM8aYd8VN0J3crEMsBzLGNMXushZOboOukUE7dtiyFOHaFtAcB1kBnJk5WD50vn5dqCmgwjXrRB/wHp/qL12+ZXG6b16BdkAqVs1pdOe4lzLMVmXi+JdzON2a/qgyWloCZysAPiAZMV1/It0nDZL+2p3CQutu+P+hWLEp6fmWCTZcNanXV7ZMODdnefowJZQmWfrSTis1pFIDE9oHP9q0d+libQKXFI5cl97vLxhRx3OUI9iU0+xokVKBzfuMFmV2Bl7fwmjhw1LLJkCCe323+qnpSLilDCoXrgOecMOEclvbpkLVZXRHJtXdH2Zww0k3F/nws9eQqaNWlETsTV3TFmEoKBgz2YxqL3OU2qdZAT8wGofcL3VNcSu6ZfoqJJOC2TVeFbY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97b5f89-b360-497b-5bec-08d751df73c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 02:20:45.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6x5IYr3fHNlF/w60PtfMSZhPKFCiiSur/BnRwPtXZim8vwVVagA6V4IpXRBE+yMTDljOm1bxNOS+ByrQPRqQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2269
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Any comments, Adrian?
Thanks.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Yangbo Lu <yangbo.lu@nxp.com>
> Sent: Wednesday, October 9, 2019 3:42 PM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>; Adri=
an
> Hunter <adrian.hunter@intel.com>
> Cc: Y.b. Lu <yangbo.lu@nxp.com>
> Subject: [v3, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171 workaroun=
d
>=20
> This patch-set is to fix up erratum A-008171 workaround. It had been veri=
fied
> on LS1046A eSDHC + Phison 32G eMMC which could trigger the erratum.
> ---
> Changes for v2:
> 	- Dropped sdhci start_tuning() hook patch.
> 	- Implemented SW tuning starting in eSDHC writew().
> Changes for v3:
> 	- Converted to use esdhc_flush_async_fifo() and usleep_range().
> 	- Added ACK of Adrian.
>=20
> Yangbo Lu (2):
>   mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
>   mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
>=20
>  drivers/mmc/host/sdhci-esdhc.h    |  14 +++
>  drivers/mmc/host/sdhci-of-esdhc.c | 257
> ++++++++++++++++++++++++++++++++------
>  2 files changed, 231 insertions(+), 40 deletions(-)
>=20
> --
> 2.7.4

