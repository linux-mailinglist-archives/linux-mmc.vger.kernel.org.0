Return-Path: <linux-mmc+bounces-7856-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F434B2B7F7
	for <lists+linux-mmc@lfdr.de>; Tue, 19 Aug 2025 05:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B816A525488
	for <lists+linux-mmc@lfdr.de>; Tue, 19 Aug 2025 03:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288B2E229D;
	Tue, 19 Aug 2025 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DgUMTgAf"
X-Original-To: linux-mmc@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC4241679;
	Tue, 19 Aug 2025 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575348; cv=fail; b=l81GaOYjS70VcP4XDYnO6tj/ay0DayL19nbBs7r5GR/mdvuZF7G8rpXcdiM0DsMbgHBgJnABGTLqSsZZ5QqoWVEUlXeh5uw4rXHutZDBIql1Ha2GVeBHdF1OmIeTy415TVJ2IbQbV7OUeT2Y7XkZARb69cfy835eBdMjI/NOCJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575348; c=relaxed/simple;
	bh=kwJ5OQIWpMtQiESEliIe651JD/cVef6oM3D/S60oY2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dti+RWJy3MykRUjKUpvThERLzdGYzg5OAAc5rARTj49Vn+uoWebc+MZbePWGOd59eYkfTNGCSJ6VwT3qHndYCAR7JMnlVDk7VjYrEk7EdHObFfDkAWsJTOWFbSMZf1hr9lcNsL+76B1tmrwYhL983zKDUik+FFdInbY/AsYcczI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DgUMTgAf; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdo6b/FipTWTaMRTXWAfJSgLA/DHjtSbsJlVh4UMg+dO39EfCZmOn/LkQzYGOWICC5PBnpoqNBvXTy3hfBQgAdCkh5MmnQY/CoM9NjNhSpK+muaOMHz/BiH/Z26kkCazsn8jiRqWj+5mdAP4DFh3zN09ApWIIUiVZPkfBGR3Z9BVCrX0pq6EiNz/yHmkx4tpXo9Vnz/bwFzcsIt3tvJOeqq29T0UDQxkWxxxiLENJm1BHKJAHehKcKS6BL+Kqcrkh5vDq0/nlTK0gFdvMSfbK0la5+XMVhNrcYFc9wzWJcuY8+RuDDXDfANn6dPTsBsGOFG1gds4v6EcY4tL0xUU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwJ5OQIWpMtQiESEliIe651JD/cVef6oM3D/S60oY2I=;
 b=mZDnrXOAlPDTNtCBW7DyBw1NlN5mUzXBCYu3WHFYO84yN1FmDnwCxhKCerqcbfKuGGIbgCqN3Lckz49cPXUgXb8CRVxyhBKG0rsFJl+XcNLs6W/Ift0OIjwEBTz5fUSnw/ZjhfhBRju7gHyZbbbZyFsLzze4mSIarlvWuMmSuLHtMpleSkHC2JXizWymUH98uyGV6u84z7SGclAe20K6l+nnxcmrUSScs6X5ikV0iLuBy/N46+zavMRofYW9AC6RFOcGkUsdZDN3HuIpFL9XKCJWQHWGGkblPkF5dwVoXjxvjYwFdHMQSSEVRgUeqBXwEbLy9rPesGeSiwE6moHnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwJ5OQIWpMtQiESEliIe651JD/cVef6oM3D/S60oY2I=;
 b=DgUMTgAfreeFtIK47Eyx3zd/oPj65LTxu++jfuGPqSUY1rK4MTgEBnpkpaZdhPaU6Eqv5Zu7CefsgTRPw215D3RZYHQWfpbR2pFeBt85ZsCLieELQo/mUdAGy/HwvXgNtI8/jCRI8uDYsgqDlGAaIMZr4N9IYHiv252fjjhgkB2rp/EEetwgRa9ZjnjwSgC5N3KvYP41Qu1P1viNnzvwB1j1EnS+Xr3xPCVV34FQyd2w1jW9y1weiGM0ICeIfd82jRzgSi16QhN6XzGn6B7fA8qsa87e7PgCOoB2yD4nqYdqAicYNiG1fLyqHQX3MsqdI66P/RIxckjpODyPR6D5ag==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB6896.eurprd04.prod.outlook.com (2603:10a6:803:12e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 03:48:57 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 03:48:57 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jisheng Zhang <jszhang@kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Aubin Constans
	<aubin.constans@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Manuel Lauss <manuel.lauss@gmail.com>,
	=?utf-8?B?TWljaGHvv73vv70gTWlyb3Pvv73vv71hdw==?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner
	<heiko@sntech.de>, Russell King <linux@armlinux.org.uk>, Chaotian Jing
	<chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
	<kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Michal Simek <michal.simek@amd.com>, Eugen
 Hristev <eugen.hristev@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <vireshk@kernel.org>, Orson
 Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
Thread-Topic: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
Thread-Index: AQHcDYdwduwgOZLH7ECF9A+giqakjLRjDCuggAG/1gCAA4x6AIABAYMQ
Date: Tue, 19 Aug 2025 03:48:57 +0000
Message-ID:
 <DU0PR04MB9496FAB31EE76054B79E05F99030A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-19-jszhang@kernel.org>
 <DU0PR04MB94962993C99F922CCF93FB6F9034A@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <aKAfRFPJQM_EtAKF@xhacker> <aKMZWjM536EOHDn9@xhacker>
In-Reply-To: <aKMZWjM536EOHDn9@xhacker>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|VI1PR04MB6896:EE_
x-ms-office365-filtering-correlation-id: c7f08908-7745-4c63-1996-08ddded3535c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2xKdXA1bGZGdVpCbDFJbTlhSnVpWVo4K1BNbktxaGxyOE8wNkVFSkVacWU4?=
 =?utf-8?B?U3J4d3kzMlBhUVBHZlNyM2xzVEErV214blBFNUdCYURsM3R3R2ZKaGdZa3BQ?=
 =?utf-8?B?QlpaUERnSzVnYjBOYmlrY3BIMmJuNWRTcEplTFBDWGVndlhIZ09uZWFYclFM?=
 =?utf-8?B?cEVFeWFpRkdJVnFoa0ZBaFJIR3lBdzRhM3dSSXE1R2d1QXlVL01HT1FYbDly?=
 =?utf-8?B?dWJhRitzajd2bHdhU1pQTm85ODFKREhYYkFXK0RjTElHa3J1U2dqekF3bXk0?=
 =?utf-8?B?OHhyOGxOYTdCRzNPbXdZWVlQUU9FOXBYUGJjUUZvSEFPRWxoazR1N3k1eFhR?=
 =?utf-8?B?eHkrV0FEZGhvL2tGZU9LdlcvRVBxM081ZjNBTld5VzdjTUxNOG9wMDlXdlJl?=
 =?utf-8?B?TnA5Yk5neUZla2lBc3NEWUpDK2xGT3J6YjV0ZlRwZko5TVQycVRTaVp2YWth?=
 =?utf-8?B?L21KMVlxdmR2YWV1R0wrdEdHc3E0YmY4WjJiUTkrMUkzWms4YWNJYWZYZzFt?=
 =?utf-8?B?RkNYT283Mi91NTVHNFJhNUhFSG11YVp2Q3psVUIzV3Z5SDNVVlNrN1RCajd0?=
 =?utf-8?B?dittRjM4ZzlPVndOL2JjZ25nNDJ1aXFTV1F2SzdoOHlEdlo0UWw4SmRzSGdG?=
 =?utf-8?B?Y25keTBoVGwxcktuNHA2ZUVqeVdaTlFYTHp2eFdVTGs3WDBJNFp2dERKZndr?=
 =?utf-8?B?OWxuN01JNnc3ZzhaeTJhSDM0cXRxbndDait3RVRhUTRLZ1lhWTdza292czdz?=
 =?utf-8?B?b1E1MURRVnVaejFCeXpvNXc2NFBHRnpkaUlpTnNvbWhmM0FrVXkxRGJZdmV3?=
 =?utf-8?B?SkUvek91eVErK1Z1ZDdYMlZaWkpLbnRJTTd0SHVlbWU2QVZNNVIxQ2cza0wz?=
 =?utf-8?B?YVdLK3crNkswWEJna251YXVKdUx0RCtnbnhSdnVIcEZlZ0c2b0RaOVhwV2hT?=
 =?utf-8?B?RmNOLzFOMlBCUzlTRnJaajJoWTkyS1Iyb1R0Q3lzRm01bHlGSWtSdWN6d0dD?=
 =?utf-8?B?SHhqZGNrSVZidTBoRGRxZUlVaE5qbjVtdW4zNHkrTThONFZGa05BZnpnTDZT?=
 =?utf-8?B?cDRrSnRCZWM2bDRsbWZWQWtramJadFVTQkdtUzNzaXREODNuN1RScmxqZDh1?=
 =?utf-8?B?L2FkOFZxRVFIdHd6VDk0TU9XZnUxeWNHd0xpY0ZSUUViUEMzR3Y2cnl3bjlv?=
 =?utf-8?B?WjlZNDhYQ2tLMFNZUmdSdDVQQ1B4eWRKSGJOVVNTMUF4a3RoeXBtL2pQa29V?=
 =?utf-8?B?aDVISFFlbVJWangra0Frd0J6cVYvUVR1WWVSZ1JYNjVRdGJ2Rmk1VEh3R1pr?=
 =?utf-8?B?bkFYaTBiMUlCNE10bytmL3NDNWRmdW9ZbFovTnpxRWZoQ0U3OUF5SnBnMi84?=
 =?utf-8?B?QXJiQXBXRWlzRHg0WnRxRExyTzE3enRzWXhmWGRXR2t6cFRlRGgyVXl1b1Zm?=
 =?utf-8?B?a1ArL2g0cHB5bkZ4MTIxblNGU1JGZmxGbW9nSTRzVGZ3MmZxKzM4czJnb3Z6?=
 =?utf-8?B?TWJpWC84bUZkcW1LcUtaZnBCbDM0cnFSUEp2N3VUaERsQldSNU4zWGsvMWV2?=
 =?utf-8?B?ejJKY1EwWm9xY2JkNTRmcDlSbVpkYWFOTlU5aFBZZzZwUXZqempzZ093Tk9O?=
 =?utf-8?B?NEgvT2cvMFpFcWZBMTg3TzFDZTIxL2RkRmVVWUNSUVJhaWNyNjFlVSsxbFJD?=
 =?utf-8?B?ZzdTaXFBaHpPaGVzTXdEQVd4ankwdkhOTnFkOWxqOGJGcWk0cldNYVJ2dE9D?=
 =?utf-8?B?YXBETXdDUnJtRUVwVitxSVM2SmFCSGRQMzFhVi8rSXo3UU1KdW9ZVVR4d0hR?=
 =?utf-8?B?cU5aR1lrQ25QVnNnVWhVTkhzbXBBNjFpNWlhRmRxdVcyKzkzeldzcXJHMTRi?=
 =?utf-8?B?azJMRDJwRWlCTmxURTFETXpUQ3hReUVZRmNaVEhPWnYxNEV4SWVQVkIvK0FK?=
 =?utf-8?B?a3UrVmhrUDJWQ2dQYS9yYjNtNHRhNWgvUEFlbW81NFhkcEVHRzIxdUVJM1Vu?=
 =?utf-8?B?OW8yWkdiK3NRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTVBVVJjdjdvMy9zT29KYlI1b3U1a3ZCeG1DY1hDMHlFSWVraWlNMzlsTWU4?=
 =?utf-8?B?eVZKcHJIOVhJU1M3cUZTMDdBaGRGTjFsc0dydFBWRElrS3JoTkYxT0pnd1BE?=
 =?utf-8?B?ME5PVElmaGV3TjZuUW1UeGVxQnF6TmZiVTNzdVYwMkx5R2MxVW91eHo0eUhk?=
 =?utf-8?B?TkE1RXJVVlJCZXpmVmNyMVFVeE9LWjA3ZFpsNjNuRi9MM0prRzVPbU15RHpQ?=
 =?utf-8?B?bkdVWDVPZDhpTFp2WTBIaEx5NEgvWE1MYUx2ZUNwRVU3cENmdkVxamx1QjBR?=
 =?utf-8?B?U2hjUjQ3TXN0cjVibEJjS0VMdjhmbHc1QmxOWWhVR2VCNXR4RGlKTWJkNHBy?=
 =?utf-8?B?RmhPZUI3OWtST2R5WHpiN3pIeXR5U0VaT1luOGhRWmRjc0Nlb0VXaHJ1SFFV?=
 =?utf-8?B?REtHaXVuMEJWTnRkZXp6N0RUbVdMOGhVZmRkeWI2Mk04dndIL01rQ1BUTXBu?=
 =?utf-8?B?SHhydFl4SFNQbVdKSVhiVmF6ZDlqaG5lTFpvTHZHaXhLM0hGQTBMUWJ2TVo5?=
 =?utf-8?B?TElLR3pUVTJhUmtVd2xTdVp4UzJxSEZUQ3ROZ1VuSU82TklmQkVZRit1cXlY?=
 =?utf-8?B?MitsT2dYcWxxWmRlRDBMLzh0VnUwZW5PSG9wdHFHQndnN2lhWmNxalEvQmht?=
 =?utf-8?B?anpIMjB6aEY0cnlQTVVSZnZYY25ydEhaOWFvTlF4Mjh3SVE5ZEJpdTlSWUZt?=
 =?utf-8?B?ZHlhM3pXeXd1S211dEJsOGNKWE1uenRkZUdrQ25rOUhvN2JHdExMaU0yRVEv?=
 =?utf-8?B?VHF2WEdwSTBQc290Sk52dFlheCtxUExkNmptdmUvQTBJbE95dXY0YzlBVFRU?=
 =?utf-8?B?SnJmd2VMVzZtd084K1gxRWY1bHM3TDZqQXVNaUR2bHRzajRUckpOU2Z2Q0dI?=
 =?utf-8?B?ZGhmM0J2dUlYWjNYT2xpZUg3d1F4cERaYUpLNXprcXpPUVc1RzRlbE93Q096?=
 =?utf-8?B?MUFhMC84dXBXTWFwUHNNMlVkWWlmbm9qYytLalAvQ0FGbmR4T24yZzVndk9a?=
 =?utf-8?B?TU1mM3h6MGZXOWdPelBWMlI5QzJpRHBMWW52cjNBTEt4N0sxcmJ4NHRsZ0RR?=
 =?utf-8?B?QnZhc1dHbGNqYzBTcGFUdGVBOXlSQ1FJWE05K2Ria2Q4QlltQUdhaVBFdTl1?=
 =?utf-8?B?YUNFMkhLRXFRaTdpU3l4MStKV1BhZVVuSzREYVh4RHVhVHlQRi9sWVlpcUVV?=
 =?utf-8?B?NjlaVWxVdU5KZWh5UERpeXZRYkYrTHdjTENUUDVQbWRsWXM1MWppWVBOTnl6?=
 =?utf-8?B?dkQrZkFzRzRHck9WZTZaVit4YTJrMk5IYlM3VTNHNXlFV3NZNndiUW5ON0Jq?=
 =?utf-8?B?SGlqZVBVcUkvQ3RYKzJFQi84VWdJOHQxaEc5c1N2UlgrU3BrRDdhNTVlcnRC?=
 =?utf-8?B?TG1uRFF4Y25jVGhrNHhWcjlBOFFjL2QwRHpxd1ZUcUFobGNiM3EzN2x3VTJO?=
 =?utf-8?B?ZE82bWZZWWF2N3FKMDZDTmM4LzRBUUtMK3loTXNTL3NSSGx0WGIyaHlpMkFG?=
 =?utf-8?B?Z0dQRjFrbEJwMHp4eE5laU95UjdWZHlHdlA5QWVGd0VOVjRDUmJvZ3NuWDdS?=
 =?utf-8?B?NytJZnNLN0d4eWZ2Ujk3VmJVVTdsdjZTbWZodGNxVWlwd0hiYTJHZTFBbTU2?=
 =?utf-8?B?NDZCdkJkUzBUWEx2dkxPZlFQK21XRFRXQ3hsUk5VZHJTMHJUNUlERFh6UTlw?=
 =?utf-8?B?VnorT1IyWk41aStMZkVZOWhUNHZTUm9raGgwa0VZM2dLTjBScHVyNzRad3JE?=
 =?utf-8?B?Z3NRVkx4bXV0N1NVTjdETzJZaEdUcWNMbXVlb0hZbUVwS3lZNDNzRzQ5U3dl?=
 =?utf-8?B?NFkwcVB3a0xsb0N6d0QzMm9PZ0VwVDhpdy9iUUFqeVRDT1VyRE8ydUJORC96?=
 =?utf-8?B?eGc0cGtzY0hGV0VESnYwcHM4Mnh6SFZONm1QWDdYVmhhQk5HZlhxaXpUUTNC?=
 =?utf-8?B?TFFBOGdpOTN6KzhvOXJ6b2hmYTk3MlVBOUJ5emlnQlJ1Ny9YWkRtbkZPQjk0?=
 =?utf-8?B?ZFhuanI2TFBMRWNDbHY2aG1xbGFjeGRoV1RTRnZpd3pzNU5VVE9lUUdvWEpR?=
 =?utf-8?B?VVpjNWRNKzk0RW1KNGRWcDU3SEM0MmExdTRhem1QOHphc2lBK2dGSzA0TEZj?=
 =?utf-8?Q?nkjw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f08908-7745-4c63-1996-08ddded3535c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 03:48:57.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sK3IUCWQF16MLCs0wx7IbnuxmSDzPFux8oT0AiAyI4I/Mu74WXrcV2v19W5V+8pg0x2fNaWjEbO72nBogmh8+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6896

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaXNoZW5nIFpoYW5nIDxqc3po
YW5nQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXlubQ45pyIMTjml6UgMjA6MTUNCj4gVG86IEJv
dWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPjsgQXViaW4gQ29uc3RhbnMNCj4gPGF1YmluLmNvbnN0YW5zQG1pY3Jv
Y2hpcC5jb20+OyBOaWNvbGFzIEZlcnJlDQo+IDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+
OyBBbGV4YW5kcmUgQmVsbG9uaQ0KPiA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+OyBD
bGF1ZGl1IEJlem5lYQ0KPiA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2PjsgTWFudWVsIExhdXNz
IDxtYW51ZWwubGF1c3NAZ21haWwuY29tPjsNCj4gTWljaGHvv73vv70gTWlyb3Pvv73vv71hdyA8
bWlycS1saW51eEByZXJlLnFtcW0ucGw+OyBKYWVob29uIENodW5nDQo+IDxqaDgwLmNodW5nQHNh
bXN1bmcuY29tPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPjsgQWxpbQ0K
PiBBa2h0YXIgPGFsaW0uYWtodGFyQHNhbXN1bmcuY29tPjsgSGVpa28gU3R1ZWJuZXIgPGhlaWtv
QHNudGVjaC5kZT47DQo+IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPjsgQ2hh
b3RpYW4gSmluZw0KPiA8Y2hhb3RpYW4uamluZ0BtZWRpYXRlay5jb20+OyBNYXR0aGlhcyBCcnVn
Z2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPjsNCj4gQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT47DQo+IFNoYXduIEd1
byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25p
eC5kZT47DQo+IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+
OyBGYWJpbyBFc3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBBZHJpYW4gSHVudGVyIDxh
ZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEthbWFsDQo+IERhc3UgPGthbWFsLmRhc3VAYnJvYWRj
b20uY29tPjsgQWwgQ29vcGVyIDxhbGNvb3BlcnhAZ21haWwuY29tPjsNCj4gQnJvYWRjb20gaW50
ZXJuYWwga2VybmVsIHJldmlldyBsaXN0DQo+IDxiY20ta2VybmVsLWZlZWRiYWNrLWxpc3RAYnJv
YWRjb20uY29tPjsgRmxvcmlhbiBGYWluZWxsaQ0KPiA8Zmxvcmlhbi5mYWluZWxsaUBicm9hZGNv
bS5jb20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gRXVnZW4gSHJp
c3RldiA8ZXVnZW4uaHJpc3RldkBsaW5hcm8ub3JnPjsgVmlnbmVzaCBSYWdoYXZlbmRyYQ0KPiA8
dmlnbmVzaHJAdGkuY29tPjsgQmVuIERvb2tzIDxiZW4tbGludXhAZmx1ZmYub3JnPjsgVmlyZXNo
IEt1bWFyDQo+IDx2aXJlc2hrQGtlcm5lbC5vcmc+OyBPcnNvbiBaaGFpIDxvcnNvbnpoYWlAZ21h
aWwuY29tPjsgQmFvbGluIFdhbmcNCj4gPGJhb2xpbi53YW5nQGxpbnV4LmFsaWJhYmEuY29tPjsg
Q2h1bnlhbiBaaGFuZyA8emhhbmcubHlyYUBnbWFpbC5jb20+Ow0KPiBQYXRyaWNlIENob3RhcmQg
PHBhdHJpY2UuY2hvdGFyZEBmb3NzLnN0LmNvbT47IFRoaWVycnkgUmVkaW5nDQo+IDx0aGllcnJ5
LnJlZGluZ0BnbWFpbC5jb20+OyBKb25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29t
PjsNCj4gQ2hlbi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPjsgSmVybmVqIFNrcmFiZWMgPGplcm5l
ai5za3JhYmVjQGdtYWlsLmNvbT47DQo+IFNhbXVlbCBIb2xsYW5kIDxzYW11ZWxAc2hvbGxhbmQu
b3JnPjsgQWxleGV5IENoYXJrb3YgPGFsY2hhcmtAZ21haWwuY29tPjsNCj4gbGludXgtbW1jQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDE4LzM4XSBtbWM6IHNkaGNpLWVzZGhjLWlteDogdXNlIG1vZGVybiBQTSBtYWNy
b3MNCj4gDQo+IE9uIFNhdCwgQXVnIDE2LCAyMDI1IGF0IDAyOjAzOjQ4UE0gKzA4MDAsIEppc2hl
bmcgWmhhbmcgd3JvdGU6DQo+ID4gT24gRnJpLCBBdWcgMTUsIDIwMjUgYXQgMDM6MjM6NTZBTSAr
MDAwMCwgQm91Z2ggQ2hlbiB3cm90ZToNCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+ID4gRnJvbTogSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0BrZXJuZWwub3JnPg0KPiA+
ID4gPiBTZW50OiAyMDI10rQ4Pz8xNT8/IDk6MzQNCj4gPiA+ID4gVG86IFVsZiBIYW5zc29uIDx1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgQXViaW4gQ29uc3RhbnMNCj4gPiA+ID4gPGF1YmluLmNv
bnN0YW5zQG1pY3JvY2hpcC5jb20+OyBOaWNvbGFzIEZlcnJlDQo+ID4gPiA+IDxuaWNvbGFzLmZl
cnJlQG1pY3JvY2hpcC5jb20+OyBBbGV4YW5kcmUgQmVsbG9uaQ0KPiA+ID4gPiA8YWxleGFuZHJl
LmJlbGxvbmlAYm9vdGxpbi5jb20+OyBDbGF1ZGl1IEJlem5lYQ0KPiA+ID4gPiA8Y2xhdWRpdS5i
ZXpuZWFAdHV4b24uZGV2PjsgTWFudWVsIExhdXNzIDxtYW51ZWwubGF1c3NAZ21haWwuY29tPjsN
Cj4gPiA+ID4gTWljaGE/PyBNaXJvcz8/YXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPjsgSmFl
aG9vbiBDaHVuZw0KPiA+ID4gPiA8amg4MC5jaHVuZ0BzYW1zdW5nLmNvbT47IEtyenlzenRvZiBL
b3psb3dza2kgPGtyemtAa2VybmVsLm9yZz47DQo+ID4gPiA+IEFsaW0gQWtodGFyIDxhbGltLmFr
aHRhckBzYW1zdW5nLmNvbT47IEhlaWtvIFN0dWVibmVyDQo+ID4gPiA+IDxoZWlrb0BzbnRlY2gu
ZGU+OyBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az47IENoYW90aWFuDQo+ID4g
PiA+IEppbmcgPGNoYW90aWFuLmppbmdAbWVkaWF0ZWsuY29tPjsgTWF0dGhpYXMgQnJ1Z2dlcg0K
PiA+ID4gPiA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT47IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vDQo+ID4gPiA+IDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+Ow0K
PiA+ID4gPiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4g
PiA+ID4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0K
PiA+ID4gPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPjsNCj4gPiA+ID4gQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+OyBLYW1hbCBEYXN1DQo+ID4gPiA+IDxrYW1hbC5kYXN1QGJyb2FkY29tLmNvbT47IEFsIENv
b3BlciA8YWxjb29wZXJ4QGdtYWlsLmNvbT47DQo+ID4gPiA+IEJyb2FkY29tIGludGVybmFsIGtl
cm5lbCByZXZpZXcgbGlzdA0KPiA+ID4gPiA8YmNtLWtlcm5lbC1mZWVkYmFjay1saXN0QGJyb2Fk
Y29tLmNvbT47IEZsb3JpYW4gRmFpbmVsbGkNCj4gPiA+ID4gPGZsb3JpYW4uZmFpbmVsbGlAYnJv
YWRjb20uY29tPjsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsNCj4gPiA+ID4gTWlj
aGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEV1Z2VuIEhyaXN0ZXYNCj4gPiA+ID4g
PGV1Z2VuLmhyaXN0ZXZAbGluYXJvLm9yZz47IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hy
QHRpLmNvbT47DQo+ID4gPiA+IEJlbiBEb29rcyA8YmVuLWxpbnV4QGZsdWZmLm9yZz47IFZpcmVz
aCBLdW1hcg0KPiA+ID4gPiA8dmlyZXNoa0BrZXJuZWwub3JnPjsgT3Jzb24gWmhhaSA8b3Jzb256
aGFpQGdtYWlsLmNvbT47IEJhb2xpbg0KPiA+ID4gPiBXYW5nIDxiYW9saW4ud2FuZ0BsaW51eC5h
bGliYWJhLmNvbT47IENodW55YW4gWmhhbmcNCj4gPiA+ID4gPHpoYW5nLmx5cmFAZ21haWwuY29t
PjsgUGF0cmljZSBDaG90YXJkDQo+ID4gPiA+IDxwYXRyaWNlLmNob3RhcmRAZm9zcy5zdC5jb20+
OyBUaGllcnJ5IFJlZGluZw0KPiA+ID4gPiA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPjsgSm9u
YXRoYW4gSHVudGVyDQo+ID4gPiA+IDxqb25hdGhhbmhAbnZpZGlhLmNvbT47IENoZW4tWXUgVHNh
aSA8d2Vuc0Bjc2llLm9yZz47IEplcm5lag0KPiA+ID4gPiBTa3JhYmVjIDxqZXJuZWouc2tyYWJl
Y0BnbWFpbC5jb20+OyBTYW11ZWwgSG9sbGFuZA0KPiA+ID4gPiA8c2FtdWVsQHNob2xsYW5kLm9y
Zz47IEFsZXhleSBDaGFya292IDxhbGNoYXJrQGdtYWlsLmNvbT4NCj4gPiA+ID4gQ2M6IGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+
ID4gU3ViamVjdDogW1BBVENIIDE4LzM4XSBtbWM6IHNkaGNpLWVzZGhjLWlteDogdXNlIG1vZGVy
biBQTSBtYWNyb3MNCj4gPiA+ID4NCj4gPiA+ID4gVXNlIHRoZSBtb2Rlcm4gUE0gbWFjcm9zIGZv
ciB0aGUgc3VzcGVuZCBhbmQgcmVzdW1lIGZ1bmN0aW9ucyB0bw0KPiA+ID4gPiBiZSBhdXRvbWF0
aWNhbGx5IGRyb3BwZWQgYnkgdGhlIGNvbXBpbGVyIHdoZW4gQ09ORklHX1BNIG9yDQo+ID4gPiA+
IENPTkZJR19QTV9TTEVFUCBhcmUgZGlzYWJsZWQsIHdpdGhvdXQgaGF2aW5nIHRvIHVzZSAjaWZk
ZWYgZ3VhcmRzLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGhhcyB0aGUgYWR2YW50YWdlIG9mIGFs
d2F5cyBjb21waWxpbmcgdGhlc2UgZnVuY3Rpb25zIGluLA0KPiA+ID4gPiBpbmRlcGVuZGVudGx5
IG9mIGFueSBLY29uZmlnIG9wdGlvbi4gVGhhbmtzIHRvIHRoYXQsIGJ1Z3MgYW5kDQo+ID4gPiA+
IG90aGVyIHJlZ3Jlc3Npb25zIGFyZSBzdWJzZXF1ZW50bHkgZWFzaWVyIHRvIGNhdGNoLg0KPiA+
ID4NCj4gPiA+IEhpIEppc2hlbmcsDQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+ID4NCj4gPiA+IFdo
ZW4gSSByZW1vdmUgYWxsIHRoZSBjb25maWdzIHVuZGVyIFBvd2VyIG1hbmFnZW1lbnQgb3B0aW9u
cyBJIGdvdCB0aGUNCj4gZm9sbG93aW5nIGJ1aWxkIHdhcm5pbmc6DQo+ID4gPg0KPiA+ID4gZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYzoyMDc5OjEyOiB3YXJuaW5nOg0KPiA+ID4g
Pz9zZGhjaV9lc2RoY19yZXN1bWU/PyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVu
Y3Rpb25dDQo+ID4gPiAgMjA3OSB8IHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfcmVzdW1lKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gPiA+ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn4NCj4gPiA+ICAgQ0MgICAgICBkcml2ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUubw0KPiA+ID4g
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYzoyMDE3OjEyOiB3YXJuaW5nOg0KPiA+
ID4gPz9zZGhjaV9lc2RoY19zdXNwZW5kPz8gZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWZ1bmN0aW9uXQ0KPiA+ID4gIDIwMTcgfCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3N1c3BlbmQo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn4NCj4gPg0KPiA+IEhtbSBpbnRlcmVzdGluZywgd2hhdCdzIHRlc3QgdG9vbGNoYWlu
PyBJIHRlc3RlZCB0aGlzIHBhdGNoIHdpdGggZ2NjMTQNCj4gPiB3aXRoIGJlbG93IHRocmVlIGNv
bWJpbmF0aW9ucyBiZWZvcmUgc2VuZGluZyBvdXQsIG5vIHdhcm5pbmdzIGF0IGFsbDoNCj4gPiBQ
TSArIFBNX1NMRUVQDQo+ID4gUE0gb25seQ0KPiA+ICFQTSArICEgUE1fU0xFRVANCj4gPg0KPiA+
IFRoZSBzZGhjaV9lc2RoY19zdXNwZW5kfHJlc3VtZSBhcmUgcmVmZXJlbmNlZCBieQ0KPiBTWVNU
RU1fU0xFRVBfUE1fT1BTLg0KPiA+IFRoZSBwbV9zbGVlcF9wdHIoKSBtYWNybyBkb2VzIHRoZSB0
cmlja3ksIHdoZW4gYm90aCBQTSBhbmQgUE1fU0xFRVANCj4gPiBhcmUgZGlzYWJsZWQsIHRoZXkg
YXJlIG9wdGltaXplZCBvdXQuDQo+IA0KPiBIaSBIYWlibywNCj4gDQo+IENvdWxkIHlvdSBwbHog
c2hhcmUgeW91ciB0b29sY2hhaW4gaW5mb3JtYXRpb24/IEFuZCBGWUksIHRvZGF5IEkgdGVzdGVk
IGNsYW5nDQo+IHdpdGggdGhlIGFib3ZlIHRocmVlIGNvbWJpbmF0aW9ucywgYWxzbyBubyB3YXJu
aW5ncy4gU28gSSdtIHJlYWxseSBpbnRlcmVzdGVkDQo+IGhvdyB0byByZXByb2R1Y2UgeW91ciB3
YXJuaW5ncy4NCj4gDQo+IEFuZCB0aGUga2VybmVsIENJIGJ1aWxkIHJvYm90IGhhc24ndCBzZW50
IG91dCB3YXJuaW5nIGVtYWlsIHNvIGZhci4NCg0KSSdtIG5vdCBzdXJlIHdoZXRoZXIgbXkgdGVz
dCBzdGVwIGlzIGNvcnJlY3QuDQpJIGZpbmQgZm9yIEFSTSwgaXQgZm9yY2UgdG8gZW5hYmxlIHRo
ZSBDT05GSUdfUE0uIHRvIHRlc3QgeW91ciBwYXRjaCwgSSBmb3JjZSByZW1vdmUgYWxsIHRoZSBQ
TSByZWxhdGVkIGNvbmZpZ3MgaW4gLmNvbmZpZy4gdGhlbiBtZWV0IHRoaXMgd2FybmluZy4gQW5k
IGFsc28gbWFueSBvdGhlciBkcml2ZXIgYnVpbGQgd2FybmluZy4NClNlZW1zIHRoaXMgdGVzdCBt
ZXRob2QgaXMgbm90IGNvcnJlY3QsIGNhbiBhbnlvbmUgY29uZmlybSBoZXJlPw0KDQpJIGRpZCBh
bm90aGVyIHRlc3QgdG9kYXksIEkgZW5hYmxlIHRoZSBDT01QSUxFX1RFU1QsIGFuZCB1c2UgeDg2
LCBjaG9zZSB0aGUgdXNkaGMgaW4gbWVudWNvbmZpZywgZGlzYWJsZSBDT05GSUdfUE0sIGFuZCBi
dWlsZCBrZXJuZWwgYnkgdGhlIGZvbGxvd2luZyBjb21tYW5kLCBkbyBub3QgbWVldCBhbnkgd2Fy
bmluZzoNCm1ha2UgQVJDSD14ODYgQ0M9Z2NjIC1qNjQNClNlZW1zIHRoaXMgbWVhbnMgIVBNICsg
IVBNX1NMRUVQIHZlcmlmeSBvay4NCg0KV2hhdCdzIHlvdXIgbWV0aG9kIHRvIHRlc3QgdGhlc2Ug
UE0gcmVsYXRlZCBjb21iaW5hdGlvbj8NCg0KUmVnYXJkcw0KSGFpYm8gY2hlbg0KDQoNCj4gDQo+
IFRoYW5rcw0KPiA+DQo+ID4gU28gY2FuIHlvdSBwbHoga2luZGx5IHNob3cgeW91ciB0b29sY2hh
aW4/IEkgd2lsbCBjaGVjaw0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gPg0KPiA+ID4gUmVnYXJkcw0K
PiA+ID4gSGFpYm8gQ2hlbg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKaXNoZW5n
IFpoYW5nIDxqc3poYW5nQGtlcm5lbC5vcmc+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDEzICsrKy0tLS0tLS0tLS0NCj4gPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+ID4g
Pg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiA+ID4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiA+ID4g
aW5kZXggYTA0MGMwODk2YTdiLi5hN2E1ZGY2NzNiMGYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ID4gPiBAQCAtMTY1MCw3ICsxNjUwLDYgQEAg
c3RhdGljIHZvaWQgc2RoY2lfZXNkaGNfaW14X2h3aW5pdChzdHJ1Y3QNCj4gPiA+ID4gc2RoY2lf
aG9zdA0KPiA+ID4gPiAqaG9zdCkNCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+
ID4gPiA+IC0jaWZkZWYgQ09ORklHX1BNX1NMRUVQDQo+ID4gPiA+ICBzdGF0aWMgdm9pZCBzZGhj
X2VzZGhjX3R1bmluZ19zYXZlKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KSAgew0KPiA+ID4gPiAg
CXN0cnVjdCBzZGhjaV9wbHRmbV9ob3N0ICpwbHRmbV9ob3N0ID0gc2RoY2lfcHJpdihob3N0KTsg
QEANCj4gPiA+ID4gLTE3MDcsNw0KPiA+ID4gPiArMTcwNiw2IEBAIHN0YXRpYyB2b2lkIHNkaGNf
ZXNkaGNfdHVuaW5nX3Jlc3RvcmUoc3RydWN0IHNkaGNpX2hvc3QNCj4gPiA+ID4gKypob3N0KQ0K
PiA+ID4gPiAgCQkgICAgICAgaG9zdC0+aW9hZGRyICsgRVNESENfVFVORV9DVFJMX1NUQVRVUyk7
DQo+ID4gPiA+ICAJfQ0KPiA+ID4gPiAgfQ0KPiA+ID4gPiAtI2VuZGlmDQo+ID4gPiA+DQo+ID4g
PiA+ICBzdGF0aWMgdm9pZCBlc2RoY19jcWVfZW5hYmxlKHN0cnVjdCBtbWNfaG9zdCAqbW1jKSAg
eyBAQCAtMjAxNiw3DQo+ID4gPiA+ICsyMDE0LDYgQEAgc3RhdGljIHZvaWQgc2RoY2lfZXNkaGNf
aW14X3JlbW92ZShzdHJ1Y3QNCj4gPiA+ID4gK3BsYXRmb3JtX2RldmljZQ0KPiA+ID4gPiAqcGRl
dikNCj4gPiA+ID4gIAkJY3B1X2xhdGVuY3lfcW9zX3JlbW92ZV9yZXF1ZXN0KCZpbXhfZGF0YS0+
cG1fcW9zX3JlcSk7DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+ID4gPiA+IC0jaWZkZWYgQ09ORklH
X1BNX1NMRUVQDQo+ID4gPiA+ICBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3N1c3BlbmQoc3RydWN0
IGRldmljZSAqZGV2KSAgew0KPiA+ID4gPiAgCXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gZGV2
X2dldF9kcnZkYXRhKGRldik7IEBAIC0yMTEyLDkNCj4gPiA+ID4gKzIxMDksNyBAQCBzdGF0aWMg
aW50IHNkaGNpX2VzZGhjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+DQo+ID4g
PiA+ICAJcmV0dXJuIHJldDsNCj4gPiA+ID4gIH0NCj4gPiA+ID4gLSNlbmRpZg0KPiA+ID4gPg0K
PiA+ID4gPiAtI2lmZGVmIENPTkZJR19QTQ0KPiA+ID4gPiAgc3RhdGljIGludCBzZGhjaV9lc2Ro
Y19ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSAgew0KPiA+ID4gPiAgCXN0cnVj
dCBzZGhjaV9ob3N0ICpob3N0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7IEBAIC0yMTg4LDEyDQo+
ID4gPiA+ICsyMTgzLDEwIEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfcnVudGltZV9yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gPiAgCQljcHVfbGF0ZW5jeV9xb3NfcmVtb3ZlX3Jl
cXVlc3QoJmlteF9kYXRhLT5wbV9xb3NfcmVxKTsNCj4gPiA+ID4gIAlyZXR1cm4gZXJyOw0KPiA+
ID4gPiAgfQ0KPiA+ID4gPiAtI2VuZGlmDQo+ID4gPiA+DQo+ID4gPiA+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IGRldl9wbV9vcHMgc2RoY2lfZXNkaGNfcG1vcHMgPSB7DQo+ID4gPiA+IC0JU0VUX1NZ
U1RFTV9TTEVFUF9QTV9PUFMoc2RoY2lfZXNkaGNfc3VzcGVuZCwNCj4gc2RoY2lfZXNkaGNfcmVz
dW1lKQ0KPiA+ID4gPiAtCVNFVF9SVU5USU1FX1BNX09QUyhzZGhjaV9lc2RoY19ydW50aW1lX3N1
c3BlbmQsDQo+ID4gPiA+IC0JCQkJc2RoY2lfZXNkaGNfcnVudGltZV9yZXN1bWUsIE5VTEwpDQo+
ID4gPiA+ICsJU1lTVEVNX1NMRUVQX1BNX09QUyhzZGhjaV9lc2RoY19zdXNwZW5kLCBzZGhjaV9l
c2RoY19yZXN1bWUpDQo+ID4gPiA+ICsJUlVOVElNRV9QTV9PUFMoc2RoY2lfZXNkaGNfcnVudGlt
ZV9zdXNwZW5kLA0KPiA+ID4gPiArc2RoY2lfZXNkaGNfcnVudGltZV9yZXN1bWUsIE5VTEwpDQo+
ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgc2RoY2lfZXNkaGNfaW14X2RyaXZlciA9IHsgQEANCj4gPiA+ID4gLTIyMDEsNyArMjE5NCw3
IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNkaGNpX2VzZGhjX2lteF9kcml2ZXIN
Cj4gPSB7DQo+ID4gPiA+ICAJCS5uYW1lCT0gInNkaGNpLWVzZGhjLWlteCIsDQo+ID4gPiA+ICAJ
CS5wcm9iZV90eXBlID0gUFJPQkVfUFJFRkVSX0FTWU5DSFJPTk9VUywNCj4gPiA+ID4gIAkJLm9m
X21hdGNoX3RhYmxlID0gaW14X2VzZGhjX2R0X2lkcywNCj4gPiA+ID4gLQkJLnBtCT0gJnNkaGNp
X2VzZGhjX3Btb3BzLA0KPiA+ID4gPiArCQkucG0JPSBwbV9wdHIoJnNkaGNpX2VzZGhjX3Btb3Bz
KSwNCj4gPiA+ID4gIAl9LA0KPiA+ID4gPiAgCS5wcm9iZQkJPSBzZGhjaV9lc2RoY19pbXhfcHJv
YmUsDQo+ID4gPiA+ICAJLnJlbW92ZQkJPSBzZGhjaV9lc2RoY19pbXhfcmVtb3ZlLA0KPiA+ID4g
PiAtLQ0KPiA+ID4gPiAyLjUwLjANCj4gPiA+DQo=

