Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB7FC54A
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 12:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfKNL2K (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 06:28:10 -0500
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:49127
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfKNL2K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Nov 2019 06:28:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVbvA38nSvRpVYlaylKcr0avrHGQ9+Qzn8b7xh1YaKspg9wWvK4rxmFy1hAwy6/FPBXnKRZYNci3wxyKMAa1323tizlMNGGhI8RawrYt1AQx56/Ml672eAgQdTslqYBaPUV3Ov2IQMTJqzqcHZJ0KkH3UuRDxS5XA1/gkN9r8TfM0Y5zz1MHOSYhTi1xNh66xoI4GuOg5BCcD0VplCxKOcTTymbpDMt8yv+EWxQ9+J0n55SveioFVDrUUjdldmzofoCXVRjj8YlLVJImdSYbjmBCTCpeaQi9uh7pVgeuidfM3zdV/hCPzC8yKYlzplQCOTw3AhJF4CZ9qV9L5HCB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDv1lJXuPzpT7uGWLueQedSdY3BQyOI/yYYeLUE6fLM=;
 b=bxXdOeXtp1sf14iJlbMzY4kXi6FMzZxhaw2F1Kk/I8tEVMbcUu1E0dVeKoJxktmuOlawya4KiBe6PgOoUCRstAAW81p/NRBqTyST3wpmlx49aOnrXTlEl1SWOqTvc76Q8xzKeA25zgPhcrPUwRIBNOnwLZxT0+03T+MuYGxTmVjNQ/WRvVriKrXgLk9LS6HABI1wXa3tE2TlBNDmAxgeAUEEP7XPkqCoaqL2GYdqiltOdzoVZBqWYqA7nSeAezBWvE4dOcJ96Lhc5d++S6zMUo7pl9oEwbJnMxggJoShyDr6Zo+V+BF+E7ESMlG3g3YgA8ZkJRO77WmchD1BwqtDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDv1lJXuPzpT7uGWLueQedSdY3BQyOI/yYYeLUE6fLM=;
 b=DUda2ogalqgHsMP4QFx2+p3qtSS58rjAycVE9/sM3YRZ2dBTh88kp/5ALasUNnfkgYVYDkJ3Wku3WtUTUzeuO7hNgBHK8XLW+JMV/Y8+LyhwvvOi+gI8c5MdGpGueL2Gd1fJUwiisFmm10NBbiOQqSRPD/ab5kBMtOMo8K/tgj0=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2605.eurprd04.prod.outlook.com (10.168.65.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 11:28:06 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::2d81:2d60:747c:d0ad]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::2d81:2d60:747c:d0ad%3]) with mapi id 15.20.2451.027; Thu, 14 Nov 2019
 11:28:06 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [PATCH] mmc: sdhci: fix up CMD12 sending
Thread-Topic: [PATCH] mmc: sdhci: fix up CMD12 sending
Thread-Index: AQHVmt010K5vWAAIEUqaLh2zVaVaTaeKhWdg
Date:   Thu, 14 Nov 2019 11:28:06 +0000
Message-ID: <VI1PR0401MB2237B2C8FC761564E868A203F8710@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
In-Reply-To: <20191114111814.35199-1-yangbo.lu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7eb2cb3b-a7de-4500-322c-08d768f5b86a
x-ms-traffictypediagnostic: VI1PR0401MB2605:|VI1PR0401MB2605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB26055CC100B97B9E3BA04F81F8710@VI1PR0401MB2605.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(13464003)(199004)(189003)(99286004)(446003)(66066001)(81156014)(81166006)(33656002)(229853002)(186003)(76176011)(476003)(316002)(102836004)(53546011)(6506007)(11346002)(6246003)(110136005)(486006)(86362001)(5660300002)(55016002)(9686003)(8676002)(7696005)(305945005)(52536014)(6436002)(8936002)(14454004)(26005)(76116006)(66946007)(71200400001)(2501003)(71190400001)(64756008)(66556008)(25786009)(66476007)(478600001)(66446008)(6116002)(2906002)(3846002)(256004)(74316002)(14444005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2605;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOr8TrrERkgILWTUDTKwR7HaxHgQr6OhyjX+E5582RULhuXL30rH51u6p9ATyoVaQvVoIAJ7LpCO8uZOSI9Lqw56CqrKxyksayP7S+oBP9jLsRf1ZjK9jdEDyqpTXiBydG0sFWpB4Gig35G5EAD7tnJyc0V9/9WZ+FnnUTPdC2aLZ0whRU+IobO1Yx6svkXvUzpQ3CBKt17VI+4A57nl+mK03Vk8ukIiJy1Qyb3vwFYCcsDtKlaty9qQ+V9TT78bCE7Id3+LwlyjmnXdNo5MjP80Uoc2SCy7D51nB5wUW+RkBkaB3L+OM35iI26DcshWYjmcrDlK38WvZ2bJT81SR1nZEfw9+HxwL1/Pt/O/nOK31f3Xjnxq5GjuhsvpjzrPLgTHsEPGVmmedKSH3x7kcaj0Yv8F0NddZy6DGfhjUzBS/i2yzbhoXQCAPGugjQjV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb2cb3b-a7de-4500-322c-08d768f5b86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 11:28:06.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTYMeDmF41caW9PFAXd1Bdovh1QnP3wasT4his9RhAjq10HfF2bVDfPBKqgHLcHX6afVhbYRS109FmH0XarN8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2605
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe and Adrian,

Actually I'm not very sure that software CMD12 won't be sent for data error=
 of multiple blocks r/w command with AUTO CMD12.
I will appreciate your help to review changes and confirm.

Thanks a lot.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Yangbo Lu <yangbo.lu@nxp.com>
> Sent: Thursday, November 14, 2019 7:18 PM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>; Adri=
an
> Hunter <adrian.hunter@intel.com>
> Cc: Y.b. Lu <yangbo.lu@nxp.com>
> Subject: [PATCH] mmc: sdhci: fix up CMD12 sending
>=20
> The STOP command is disabled for multiple blocks r/w commands with auto
> CMD12, when start to send. However, if there is data error, software stil=
l needs
> to send CMD12 according to SD spec.
> This patch is to allow software CMD12 sending for this case.
>=20
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 09cdbe8..3041c39 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1326,12 +1326,12 @@ static void sdhci_finish_data(struct sdhci_host
> *host)
>=20
>  	/*
>  	 * Need to send CMD12 if -
> -	 * a) open-ended multiblock transfer (no CMD23)
> +	 * a) open-ended multiblock transfer not using auto CMD12 (no CMD23)
>  	 * b) error in multiblock transfer
>  	 */
>  	if (data->stop &&
> -	    (data->error ||
> -	     !data->mrq->sbc)) {
> +	    ((!data->mrq->sbc && !sdhci_auto_cmd12(host, data->mrq)) ||
> +	     data->error)) {
>  		/*
>  		 * 'cap_cmd_during_tfr' request must not use the command line
>  		 * after mmc_command_done() has been called. It is upper layer's
> @@ -1825,17 +1825,6 @@ void sdhci_request(struct mmc_host *mmc, struct
> mmc_request *mrq)
>=20
>  	sdhci_led_activate(host);
>=20
> -	/*
> -	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
> -	 * requests if Auto-CMD12 is enabled.
> -	 */
> -	if (sdhci_auto_cmd12(host, mrq)) {
> -		if (mrq->stop) {
> -			mrq->data->stop =3D NULL;
> -			mrq->stop =3D NULL;
> -		}
> -	}
> -
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		mrq->cmd->error =3D -ENOMEDIUM;
>  		sdhci_finish_mrq(host, mrq);
> --
> 2.7.4

