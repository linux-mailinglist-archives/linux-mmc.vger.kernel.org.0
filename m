Return-Path: <linux-mmc+bounces-1550-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B6088A354
	for <lists+linux-mmc@lfdr.de>; Mon, 25 Mar 2024 14:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6D71F3D4F0
	for <lists+linux-mmc@lfdr.de>; Mon, 25 Mar 2024 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFE816E87F;
	Mon, 25 Mar 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F+bSE7f9"
X-Original-To: linux-mmc@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C645145FEF;
	Mon, 25 Mar 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359051; cv=fail; b=dx45/Fys3cHrqxGLYe/SVQYL0FIGwcInGsl0QHFuYIntsizyGlQAr+JL+k4SM0infsLyKopuZD1O0auXZetH0Nx6WLlSkQ2pCn8RP7mQ03R3btIhkIiC3rnIiWtNSqV32DSNTuPLei9UHF/kZJf7bPUC1NSalLJPwV0PMVw/AfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359051; c=relaxed/simple;
	bh=LhPgxUPGakj9gTqPisf5SbjgXey8DqqsGvVoGPCwFEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GmXfK5kuXuPYcr2HdqItJBkGssuHMcSWqS81fIpaJVTEghyA/0U1qni1xLvHQhI5tfWzxKG8xXReeeiDFKGSBEEgccGJHZg5KDgafQXfBEFRV2tFU4YaOXkYVtTSkXbQYmuVK/Pw/qSx/Bo1TH55yQUxVrjJ6BwWWmDsKbVV6Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F+bSE7f9; arc=fail smtp.client-ip=40.107.104.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZEQDhpRDNGG/ZQDuLZ5E/NV6iKc8nPrhROsaJ+5JcUI0R0zDG1Q0N1sJoAPPtRZc2L4OCDJpLpoOr3z+qhP9LlVDdfh7ySxJVEiKVbScl5P1CCAfniTI7kQNQxOQc0uEZftXNpqIdnwU4BCptoF+IRpJyc8Om7tqmmS0pxNJpXjom7wz+56i3JHLTkN8k52l1WD4ipsgqUF0/8/CYfFdjRleSbz45LeQ5D8YShHCJk/ro3QLEFJBnrlcDuq34VQDZdJyKfETpBQiPAN0ZJREWoaiah4wmaKDbmy3RWvCChcj3S0nFS4ZsUiOg060fKkMCcPCMfvoI6DnPgQS9TRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao9P702hCeucF2JTfbUpt1+b9eTvi0Bbt4EHqoFw00w=;
 b=jUeNoz/tBgDBAe/bnQuDrxB78hw2HULoPWlvBpSzz1zPlJ1tW0IXrl/pxJiXjISdSREJ3/rdfuQFZlPh00RB/wNLjAR6i+YNRXn6hebH/bKfkwxmiYdVWrQgqWcnkfvRdUvhOTDU/OHF/rSnUlpCYWfWzlCQ8BLLvs0g04BjDTShf+8quu5gB3TziqlckpSSLRNoBVTYpIzPe1rCDxBJeQxnQ9PTddxbsy9jBqg/jaej1/2WGjwgd1XUuKLr0iBXqed1biZxGlf2FC1BG7LR7pAcCHwMQpf5KaXEBOklQXKPki6w0i5LYUWjFi0rNs8BlFpef1xX+63uY1uoIc6q3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao9P702hCeucF2JTfbUpt1+b9eTvi0Bbt4EHqoFw00w=;
 b=F+bSE7f91BgTIgIS9RCFqi3JJRphovUyXEa4DoJy5FGuSiAQ6MchRi9aevq9PcTOpiE73JhY5VQE/6O3qZBM/5/K+wEIwa2yuzd5ewAlRlKgALCpHAK7ajHWZy9wc/GUuOLqAYLHf02C3j63UGVDopOD8ugBeiT9pLK6P/L5jJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by VI2PR04MB10167.eurprd04.prod.outlook.com (2603:10a6:800:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Mon, 25 Mar
 2024 09:30:43 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::6fd2:46ce:25c0:3dd7]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::6fd2:46ce:25c0:3dd7%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:30:43 +0000
Message-ID: <df6f2a09-8125-4c1a-9dfd-3217233dc076@oss.nxp.com>
Date: Mon, 25 Mar 2024 11:30:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Content-Language: en-US
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Marco Felsch <m.felsch@pengutronix.de>,
 Marek Vasut <marex@denx.de>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Josua Mayer <josua@solid-run.com>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20240324214329.29988-1-wafgo01@gmail.com>
 <20240324214329.29988-5-wafgo01@gmail.com>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20240324214329.29988-5-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::14) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|VI2PR04MB10167:EE_
X-MS-Office365-Filtering-Correlation-Id: 315f0faa-46ce-48ed-d5c8-08dc4cae3e36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 YZWxNJrTehGM7AGPzBfEQ5fprwMNw1toyTq1QCZgIvw+JdwaWMyQwJCIbU1UpBO2u8G+LeTsGzpjf24WdaoWNOPSHn6XlteZoa0+tGWZ7tOtUuWC3Hiuf2Wu0uD7Zgi8/yG6z56ZZv7N3g3o+dQ3K0EnttYgDMAdtWn5RRzDSA9o7BCSmkf/s6NjB7yvq2RB9P/9av9PT0e69gWNwS6uLGwSK7C7lr7qfY0Zpavr7kQESV5uXC2/BwsoXAp/SYys+4gIvscbRb2BbUkKOKR7a0aZCYGoZGTDCXGiuOCkvMjTC77cjkRiR2zH66d589hScZYiBSVTPDzJk2BLE8VZEHqIM9tdNk1bWK+XPTHeODw9qcF8zenaMgRKDlcnMyunRsyKqvvOkHcT5+mNSqaDcQFxdeChY8ySQt4FOsR2DQNGRMumfpkoSlKBDpG3nGtHetyDSJeAmlYhibjSiwC7zgeSvuUHY1qk7X3/TX0LFK5iMXVg7dTyRgpR26XTdC5Vk5QascZ6rjJrIB4KAkhx6XlARw3Hprfx84hKHORZZwah5FWYlvgMCvbbG06imeMDiZHja6Hg4VzcGX5E86O+dsLIHUGyb9Ox2jUbqThglB0I6DhqTRVZl42VjFbXHnUE
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MVhJOE00L0p2MGlYZUhqTlhsZzB6ZFB6UjlEUHMvNGlzZk1UampZT3NwM3JX?=
 =?utf-8?B?VnZwZ21mdVppUVJhdjJjR25lazNEclNMQ2lsWWpFMjQrT3E3b1VKMC9LWkVV?=
 =?utf-8?B?MVhCdEJ3Y1I2VitXTk4zZW9YYXFvVytLMHJYbWkvMXlWczVNcHlUbWZHdjgv?=
 =?utf-8?B?dlhFRkFjYVV4ZDdQYlNYYWpqTmh4K0FFQndwTFR3S3lLbDFENXJqRnFyZ2ND?=
 =?utf-8?B?TjVnbFRueDc3RFV1ZzBWa3VIdUpuZFJkdmxrZW9vOWc1TXk1c0g0Tm55bVNJ?=
 =?utf-8?B?eVZGcnV3UndDZlk0YlZ3QUZMOW5BelNjTkRMU1VkbXV3SE4vNGVLRmdPOEt4?=
 =?utf-8?B?WWdXd2VXYldqSUhRMFhFbTMzMncyWmN5amh0bTlvTlhYdXc4NGpxSEVlejMx?=
 =?utf-8?B?cGcvWUhZNXR4QnpjSUhmWHNLYTVNZXZBSjE4elhXUm9jeXUzUitadVR1dSts?=
 =?utf-8?B?U0NrSkpiK2MxTTJZTzNqSUo0eG5jQ0FwSTVacWdqS0VNNHRKYXp4QXBvbWln?=
 =?utf-8?B?ZWZnR0h4T0xVM0p0NG1YNnR3Wi9xZDl3VnBTV1RBTXNpTFp1RmovaUxsekQ0?=
 =?utf-8?B?aEZxbUVGVGhCUWNDcjVyalRrVDN5QWM3UHV2L0FLSnlDOXJDMkJ1WUk2YmhC?=
 =?utf-8?B?ZXZHVTVyMGdpZzJ0M0p2Z2pEanp3VDBMcE5YVFZ6bzBMWm96bGxBYmJsSkJ6?=
 =?utf-8?B?UXdpako1SWl6b25DRmRrSlpzc3BZSEROdkE5dG9UWjlHekFzTFRJaUdEQUI5?=
 =?utf-8?B?Y1lCaVNEc2VqN000VVlBTnZucDUvYlMxYXErN3RmZ0sxOVJZTkJ0T2hybUwz?=
 =?utf-8?B?VnpzMW9Jajg2bDVJWEJFcVJjQUttMGJqVWlzRWJma2RNODAxb0dJK3FkWFlp?=
 =?utf-8?B?OGF5NVlHL29UNCtMVjVRTHFtenVkYUlnU2pQMFRBQ21MY0YzUlJHbjkya1Ra?=
 =?utf-8?B?S0dZSUNWT3pnZDQ4dnorUFVwOXVtRmthTEM1QnpzbnJlUENTSTVhVzFEcytX?=
 =?utf-8?B?UVoxaEhVNkhsR3ltK0gxUEpGTlpwOHVNa3JLaWI0MHF5VGMzaDYvM1N6Vkcv?=
 =?utf-8?B?ZVFVZUdSU3NLVndCTldOb3l1UkJLblJ1bm90aWdkbnZkWE8wSjNINFFhTkEw?=
 =?utf-8?B?N3NOaUFFZUo0OElZaFFjUXdqS0JxeXdqTW1kbkY3cjZFUC81WC8wbXJwYVdr?=
 =?utf-8?B?YmdkRGVaZ0x6RGdXd3M5STRnVzJHTm1icVFjZEdxL0RvS2EzK2hpZXlNNjZU?=
 =?utf-8?B?bDEwOFVOSlk0SjRpMGRQdSsyRzVVWXhGMHBtVWhFL2tHQzVMTldxbVp0SS9i?=
 =?utf-8?B?N3RQUU50cVdKdlFOZVB3WmJkQmxkbWV1ZGtwMVRDblRmUnpkaXlncGtOQnlh?=
 =?utf-8?B?UUw0M2xkWEpLellVTTRkd1hkd1pkZi9lNnBqRG43emJCQ016cUhOOE02MVpP?=
 =?utf-8?B?QmNkTGFWcnBpaEJPbGtzN2FQSXBYekRnN2I5cE1YTHhMWEJvUWJiOXQ1OVVp?=
 =?utf-8?B?V0I0QVdZK0VUVXJpMFZSUG12ZEtUYkRtc01SUUZDSDZNMnhrcm1BMUdjRU05?=
 =?utf-8?B?T29xdmxPcDBNOGFsR3FIQTBlOFVZYm44aGYwaVZaTll3TGo0aEZ3Z1lLMVJM?=
 =?utf-8?B?QTJvRGQ0ZTdsKytlemNJYi9NL2FRcko0eFNYdzNoKzZBdDFpZUZmRU1EczJQ?=
 =?utf-8?B?NzFMYk93ZGFncDR5MW5uMjNXWCtNTUI4SkRQWmtHT0FUSkt3WW9STUJCeEta?=
 =?utf-8?B?T3JxS3JwTURDQnY3dFVqMEpEZGhGbGFXRms5Wml5YUNKYUJNMUxpdGdoZmF1?=
 =?utf-8?B?eVRFOE5KTEUzZnRzZHN3Mnd6d1VGcHc5WVh6b0hCTnVDTkVzaFdEVVRaQ0l0?=
 =?utf-8?B?ZmtiRUxvWXNYSlhGM2dvNjRiSDhaSW1hZ3B4eVRzalQ5MUFNbW1NRlJnSUtL?=
 =?utf-8?B?a0oweHNNcGtuTUdaZDY2VklGSUdpVlQ4bElrWndDRDVReTdhOU11amlCSStq?=
 =?utf-8?B?Y0ovVGljcFJ0U3ZRT0VBY0tuMWx4blZRS21YU0hWZUlWZVRvOU1pL0RvK0cv?=
 =?utf-8?B?RXBiS3FHM2RmU3JtWnk3NE1VZjdYU2NUQjBzUlFuL3h0VHZqV2UyenpmLzhh?=
 =?utf-8?B?QXplMWZwU1FOcWtkbkF5SldSbEJqT1cvL1ZxN3E5RlQ3bW1xZWQ1Q1A5aExK?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315f0faa-46ce-48ed-d5c8-08dc4cae3e36
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:30:43.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq65JNkmFjzXJDPVqqJo+3ohPQKUT2owXzP9dV+pKoKaorlAApNj9HiIPXj4YX351nyfXMpIzA7dJi/2q0BIxfiN+uD7NLGkxvba7Cu3qJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10167

On 3/24/24 23:43, Wadim Mueller wrote:
> This commit adds device tree support for the NXP S32G3-based
> S32G-VNP-RDB3 Board [1].
> 
> The S32G3 features an 8-core ARM Cortex-A53 based SoC developed by NXP.
> 
> The device tree files are derived from the official NXP downstream
> Linux tree [2].
> 
> This addition encompasses a limited selection of peripherals that
> are upstream-supported. Apart from the ARM System Modules
> (GIC, Generic Timer, etc.), the following IPs have been validated:
> 
>     * UART: fsl-linflexuart
>     * SDHC: fsl-imx-esdhc
> 
> Clock settings for the chip rely on ATF Firmware [3].
> Pin control integration into the device tree is pending and currently
> relies on Firmware/U-Boot settings [4].
> 
> These changes were validated using BSP39 Firmware/U-Boot from NXP [5].
> 
> The modifications enable booting the official Ubuntu 22.04 from NXP on
> the RDB3 with default settings from the SD card and eMMC.
> 
> [1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
> [2] https://github.com/nxp-auto-linux/linux
> [3] https://github.com/nxp-auto-linux/arm-trusted-firmware
> [4] https://github.com/nxp-auto-linux/u-boot
> [5] https://github.com/nxp-auto-linux/auto_yocto_bsp
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---

Thank you, Wadim, for bringing up the S32G3RDB3 board! The board boots
with all 8 cores. The log is attached below.

Tested-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Reviewed-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.9.0-rc1-00004-gcb630dd69df3
(nxa06643@lxl00026) (aarch64-linux-gnu-gcc (Linaro GCC 7.5-2019.12)
7.5.0, GNU ld (Linaro_Binutils-2019.12) 2.28.2.20170706) #21 SMP PREEMPT
Mon Mar 25 10:50:16 EET 2024
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: NXP S32G3 Reference Design Board 3
(S32G-VNP-RDB3)
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x00000000d0000000..0x00000000d000007f
(0 KiB) nomap non-reusable shm@d0000000
[    0.000000] OF: reserved mem: 0x00000000ff600000..0x00000000ff7fffff
(2048 KiB) nomap non-reusable atf@ff600000
[    0.000000] earlycon: linflex0 at MMIO 0x00000000401c8000 (options
'115200n8')
[    0.000000] printk: legacy bootconsole [linflex0] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000080000000-0x00000008dfffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x8df8ff9c0-0x8df901fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008dfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000cfffffff]
[    0.000000]   node   0: [mem 0x00000000d0001000-0x00000000ff5fffff]
[    0.000000]   node   0: [mem 0x00000000ff600000-0x00000000ff7fffff]
[    0.000000]   node   0: [mem 0x00000000ff800000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000008dfffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000080000000-0x00000008dfffffff]
[    0.000000] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fd600000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 24 pages/cpu s57896 r8192 d32216 u98304
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: console=ttyLF0,115200
root=/dev/mmcblk0p2 rootwait rw earlycon
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 903167
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem
0x00000000f9600000-0x00000000fd600000] (64MB)
[    0.000000] Memory: 3451804K/3670012K available (17472K kernel code,
4790K rwdata, 11432K rodata, 9984K init, 754K bss, 185440K reserved,
32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=512 to
nr_cpu_ids=8.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] RCU Tasks: Setting shift to 3 and lim to 1
rcu_task_cb_adjust=1.
[    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1
rcu_task_cb_adjust=1.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: 544 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region
0:0x0000000050900000
[    0.000000] ITS: No ITS available, not enabling LPIs
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on
contention.
[    0.000000] arch_timer: cp15 timer(s) running at 5.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x127350b88, max_idle_ns: 440795202120 ns
[    0.000001] sched_clock: 56 bits at 5MHz, resolution 200ns, wraps
every 4398046511100ns
[    0.008224] Console: colour dummy device 80x25
[    0.012493] Calibrating delay loop (skipped), value calculated using
timer frequency.. 10.00 BogoMIPS (lpj=20000)
[    0.022661] pid_max: default: 32768 minimum: 301
[    0.027333] LSM: initializing lsm=capability
[    0.031604] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    0.038904] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
[    0.047831] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.054481] rcu: Hierarchical SRCU implementation.
[    0.058926] rcu:     Max phase no-delay instances is 1000.
[    0.064746] EFI services will not be available.
[    0.069258] smp: Bringing up secondary CPUs ...
[    0.073964] Detected VIPT I-cache on CPU1
[    0.074018] GICv3: CPU1: found redistributor 1 region
0:0x0000000050920000
[    0.074056] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.074630] Detected VIPT I-cache on CPU2
[    0.074662] GICv3: CPU2: found redistributor 2 region
0:0x0000000050940000
[    0.074682] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.075227] Detected VIPT I-cache on CPU3
[    0.075258] GICv3: CPU3: found redistributor 3 region
0:0x0000000050960000
[    0.075277] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.075831] Detected VIPT I-cache on CPU4
[    0.075885] GICv3: CPU4: found redistributor 100 region
0:0x0000000050980000
[    0.075917] CPU4: Booted secondary processor 0x0000000100 [0x410fd034]
[    0.076492] Detected VIPT I-cache on CPU5
[    0.076527] GICv3: CPU5: found redistributor 101 region
0:0x00000000509a0000
[    0.076547] CPU5: Booted secondary processor 0x0000000101 [0x410fd034]
[    0.077090] Detected VIPT I-cache on CPU6
[    0.077127] GICv3: CPU6: found redistributor 102 region
0:0x00000000509c0000
[    0.077147] CPU6: Booted secondary processor 0x0000000102 [0x410fd034]
[    0.077724] Detected VIPT I-cache on CPU7
[    0.077765] GICv3: CPU7: found redistributor 103 region
0:0x00000000509e0000
[    0.077785] CPU7: Booted secondary processor 0x0000000103 [0x410fd034]
[    0.077896] smp: Brought up 1 node, 8 CPUs
[    0.203873] SMP: Total of 8 processors activated.
[    0.208551] CPU: All CPU(s) started at EL1
[    0.212660] CPU features: detected: 32-bit EL0 Support
[    0.217751] CPU features: detected: 32-bit EL1 Support
[    0.222885] CPU features: detected: CRC32 instructions
[    0.228042] alternatives: applying system-wide alternatives
[    0.236019] devtmpfs: initialized
[    0.242628] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.252037] futex hash table entries: 2048 (order: 5, 131072 bytes,
linear)
[    0.260021] pinctrl core: initialized pinctrl subsystem
[    0.266046] DMI not present or invalid.
[    0.272094] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.278654] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic
allocations
[    0.285546] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.293318] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[    0.301019] audit: initializing netlink subsys (disabled)
[    0.306513] audit: type=2000 audit(0.180:1): state=initialized
audit_enabled=0 res=1
[    0.307304] thermal_sys: Registered thermal governor 'step_wise'
[    0.314096] thermal_sys: Registered thermal governor 'power_allocator'
[    0.320130] cpuidle: using governor menu
[    0.330730] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.337396] ASID allocator initialised with 65536 entries
[    0.344482] Serial: AMBA PL011 UART driver
[    0.350914] Modules: 21600 pages in range for non-PLT usage
[    0.350920] Modules: 513120 pages in range for PLT usage
[    0.356758] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.368493] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.374744] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.381511] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.387762] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.394531] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.400784] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.407551] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.414206] Demotion targets for Node 0: null
[    0.419168] ACPI: Interpreter disabled.
[    0.423692] iommu: Default domain type: Translated
[    0.428153] iommu: DMA domain TLB invalidation policy: strict mode
[    0.434805] SCSI subsystem initialized
[    0.438513] usbcore: registered new interface driver usbfs
[    0.443706] usbcore: registered new interface driver hub
[    0.448995] usbcore: registered new device driver usb
[    0.454351] pps_core: LinuxPPS API ver. 1 registered
[    0.458968] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.468095] PTP clock support registered
[    0.472054] EDAC MC: Ver: 3.0.0
[    0.475481] scmi_core: SCMI protocol bus registered
[    0.480546] FPGA manager framework
[    0.483666] Advanced Linux Sound Architecture Driver Initialized.
[    0.490590] vgaarb: loaded
[    0.493333] clocksource: Switched to clocksource arch_sys_counter
[    0.499297] VFS: Disk quotas dquot_6.6.0
[    0.503017] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    0.510017] pnp: PnP ACPI: disabled
[    0.519430] NET: Registered PF_INET protocol family
[    0.524185] IP idents hash table entries: 65536 (order: 7, 524288
bytes, linear)
[    0.533803] tcp_listen_portaddr_hash hash table entries: 2048 (order:
3, 32768 bytes, linear)
[    0.542061] Table-perturb hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.549719] TCP established hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.557803] TCP bind hash table entries: 32768 (order: 8, 1048576
bytes, linear)
[    0.566154] TCP: Hash tables configured (established 32768 bind 32768)
[    0.572472] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.579091] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes,
linear)
[    0.586323] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.592198] RPC: Registered named UNIX socket transport module.
[    0.597778] RPC: Registered udp transport module.
[    0.602457] RPC: Registered tcp transport module.
[    0.607143] RPC: Registered tcp-with-tls transport module.
[    0.612612] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.619048] PCI: CLS 0 bytes, default 64
[    0.623428] kvm [1]: HYP mode not available
[    0.628384] Initialise system trusted keyrings
[    0.632632] workingset: timestamp_bits=42 max_order=20 bucket_order=0
[    0.639182] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.644948] NFS: Registering the id_resolver key type
[    0.649780] Key type id_resolver registered
[    0.653921] Key type id_legacy registered
[    0.657932] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.664597] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[    0.672111] 9p: Installing v9fs 9p2000 file system support
[    0.714617] Key type asymmetric registered
[    0.718368] Asymmetric key parser 'x509' registered
[    0.723278] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 245)
[    0.730608] io scheduler mq-deadline registered
[    0.735119] io scheduler kyber registered
[    0.739144] io scheduler bfq registered
[    0.764751] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.773400] 401c8000.serial: ttyLF0 at MMIO 0x401c8000 (irq = 14,
base_baud = 0) is a FSL_LINFLEX
[    0.783976] printk: legacy console [ttyLF0] enabled
[    0.783976] printk: legacy console [ttyLF0] enabled
[    0.793930] printk: legacy bootconsole [linflex0] disabled
[    0.793930] printk: legacy bootconsole [linflex0] disabled
[    0.809777] 401cc000.serial: ttyLF1 at MMIO 0x401cc000 (irq = 15,
base_baud = 0) is a FSL_LINFLEX
[    0.819329] msm_serial: driver initialized
[    0.823695] SuperH (H)SCI(F) driver initialized
[    0.828378] STM32 USART driver initialized
[    0.840105] loop: module loaded
[    0.844169] megasas: 07.727.03.00-rc1
[    0.852986] tun: Universal TUN/TAP device driver, 1.6
[    0.858691] thunder_xcv, ver 1.0
[    0.862013] thunder_bgx, ver 1.0
[    0.865323] nicpf, ver 1.0
[    0.868818] hns3: Hisilicon Ethernet Network Driver for Hip08 Family
- version
[    0.876179] hns3: Copyright (c) 2017 Huawei Corporation.
[    0.881621] hclge is initializing
[    0.885029] e1000: Intel(R) PRO/1000 Network Driver
[    0.889999] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.895874] e1000e: Intel(R) PRO/1000 Network Driver
[    0.900932] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.906982] igb: Intel(R) Gigabit Ethernet Network Driver
[    0.912483] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.918195] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    0.924581] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.930796] sky2: driver version 1.30
[    0.935382] VFIO - User Level meta-driver version: 0.3
[    0.942227] usbcore: registered new interface driver usb-storage
[    0.950179] i2c_dev: i2c /dev entries driver
[    0.959203] sdhci: Secure Digital Host Controller Interface driver
[    0.965503] sdhci: Copyright(c) Pierre Ossman
[    0.970334] Synopsys Designware Multimedia Card Interface Driver
[    0.976987] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.983975] ledtrig-cpu: registered to indicate activity on CPUs
[    0.990556] scmi_protocol scmi_dev.1: Enabled polling mode TX channel
- prot_id:16
[    0.998513] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    1.005209] arm-scmi firmware:scmi: SCMI Protocol v2.0 'NXP:S32G399A'
Firmware version 0x0
[    1.014897] cpu cpu0: EM: only supports uW power values
[    1.025027] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    1.032401] usbcore: registered new interface driver usbhid
[    1.038094] usbhid: USB HID core driver
[    1.044180] hw perfevents: enabled with armv8_cortex_a53 PMU driver,
7 counters available
[    1.056194] NET: Registered PF_PACKET protocol family
[    1.061445] 9pnet: Installing 9P2000 support
[    1.065867] Key type dns_resolver registered
[    1.079732] Timer migration: 1 hierarchy levels; 8 children per
group; 1 crossnode level
[    1.088206] registered taskstats version 1
[    1.092820] Loading compiled-in X.509 certificates
[    1.115627] clk: Disabling unused clocks
[    1.117662] sdhci-esdhc-imx 402f0000.mmc: could not get pinctrl
[    1.119704] PM: genpd: Disabling unused power domains
[    1.130853] ALSA device list:
[    1.133886]   No soundcards found.
[    1.157133] mmc0: SDHCI controller on 402f0000.mmc [402f0000.mmc]
using ADMA
[    1.164512] Waiting for root device /dev/mmcblk0p2...
[    1.185787] mmc0: host does not support reading read-only switch,
assuming write-enable
[    1.195000] mmc0: new high speed SDHC card at address 5048
[    1.201102] mmcblk0: mmc0:5048 SD32G 29.7 GiB
[    1.208397]  mmcblk0: p1 p2
[    1.238459] EXT4-fs (mmcblk0p2): recovery complete
[    1.244613] EXT4-fs (mmcblk0p2): mounted filesystem
52830f5f-ab50-4125-a606-3c65100b7d4a r/w with ordered data mode. Quota
mode: none.
[    1.257000] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    1.264390] devtmpfs: mounted
[    1.271069] Freeing unused kernel memory: 9984K
[    1.275760] Run /sbin/init as init process
[    1.657291] systemd[1]: System time before build time, advancing clock.
[    1.714423] systemd[1]: systemd 250.5+ running in system mode (+PAM
-AUDIT -SELINUX -APPARMOR +IMA -SMACK +SECCOMP -GCRYPT -GNUTLS -OPENSSL
+ACL +BLKID -CURL -ELFUTILS -FIDO2 -IDN2 -IDN -IPTC +KMOD -LIBCRYPTSETUP
+LIBFDISK -PCRE2 -PWQUALITY -P11KIT -QRENCODE -BZIP2 -LZ4 -XZ -ZLIB
+ZSTD -BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=hybrid)
[    1.746891] systemd[1]: Detected architecture arm64.

Welcome to Auto Linux BSP develop (kirkstone)!

[    1.845928] systemd[1]: Hostname set to <s32g399ardb3>.
[    2.186158] systemd[1]: Binding to IPv6 address not available since
kernel does not support IPv6.
[    2.195287] systemd[1]: Binding to IPv6 address not available since
kernel does not support IPv6.
[    2.317364] systemd[1]: Queued start job for default target
Multi-User System.
[    2.396694] systemd[1]: Created slice Slice /system/getty.
[  OK  ] Created slice Slice /system/getty.
[    2.410476] systemd[1]: Created slice Slice /system/modprobe.
[  OK  ] Created slice Slice /system/modprobe.
[    2.424209] systemd[1]: Created slice Slice /system/serial-getty.
[  OK  ] Created slice Slice /system/serial-getty.
[    2.438389] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[    2.450954] systemd[1]: Started Dispatch Password Requests to Console
Directory Watch.
[  OK  ] Started Dispatch Password …ts to Console Directory Watch.
[    2.467638] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[  OK  ] Started Forward Password R…uests to Wall Directory Watch.
[    2.484011] systemd[1]: Reached target Path Units.
[  OK  ] Reached target Path Units.
[    2.494464] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[    2.506485] systemd[1]: Reached target Slice Units.
[  OK  ] Reached target Slice Units.
[    2.517119] systemd[1]: Reached target Swaps.
[  OK  ] Reached target Swaps.
[    2.586411] systemd[1]: Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on RPCbind Server Activation Socket.
[    2.600701] systemd[1]: Reached target RPC Port Mapper.
[  OK  ] Reached target RPC Port Mapper.
[    2.612616] systemd[1]: Listening on Syslog Socket.
[  OK  ] Listening on Syslog Socket.
[    2.623452] systemd[1]: Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[    2.637954] systemd[1]: Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Audit Socket.
[    2.650037] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[    2.663102] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    2.674363] systemd[1]: Listening on Network Service Netlink Socket.
[  OK  ] Listening on Network Service Netlink Socket.
[    2.688327] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    2.700193] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    2.711963] systemd[1]: Listening on User Database Manager Socket.
[  OK  ] Listening on User Database Manager Socket.
[    2.749696] systemd[1]: Mounting Huge Pages File System...
         Mounting Huge Pages File System...
[    2.764346] systemd[1]: Mounting POSIX Message Queue File System...
         Mounting POSIX Message Queue File System...
[    2.780591] systemd[1]: Mounting Kernel Debug File System...
         Mounting Kernel Debug File System...
[    2.792560] systemd[1]: Kernel Trace File System was skipped because
of a failed condition check (ConditionPathExists=/sys/kernel/tracing).
[    2.805768] systemd[1]: Create List of Static Device Nodes was
skipped because of a failed condition check
(ConditionFileNotEmpty=/lib/modules/6.9.0-rc1-00004-gcb630dd69df3/modules.devname).
[    2.826957] systemd[1]: Starting Load Kernel Module configfs...
         Starting Load Kernel Module configfs...
[    2.842860] systemd[1]: Starting Load Kernel Module drm...
         Starting Load Kernel Module drm...
[    2.857874] systemd[1]: Starting Load Kernel Module fuse...
         Starting Load Kernel Module fuse...
[    2.879679] systemd[1]: Starting RPC Bind...
         Starting RPC Bind...
[    2.888514] systemd[1]: File System Check on Root Device was skipped
because of a failed condition check (ConditionPathIsReadWrite=!/).
[    2.907067] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[    2.925119] systemd[1]: Starting Load Kernel Modules...
         Starting Load Kernel Modules...
[    2.940298] systemd[1]: Starting Generate network units from Kernel
command line...
         Starting Generate network …ts from Kernel command line...
[    2.959955] systemd[1]: Starting Remount Root and Kernel File Systems...
         Starting Remount Root and Kernel File Systems...
[    2.977958] systemd[1]: Starting Coldplug All udev Devices...
         Starting Coldplug All udev Devices...
[    2.995944] systemd[1]: Started RPC Bind.
[  OK  ] Started RPC Bind.
[    3.005902] systemd[1]: Mounted Huge Pages File System.
[  OK  ] Mounted Huge Pages File System.
[    3.018033] systemd[1]: Mounted POSIX Message Queue File System.
[  OK  ] Mounted POSIX Message Queue File System.[    3.029658] EXT4-fs
(mmcblk0p2): re-mounted 52830f5f-ab50-4125-a606-3c65100b7d4a r/w. Quota
mode: none.

[    3.043175] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
[  OK  ] Mounted Kernel Debug File System.
[  OK  ] Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module drm.
[  OK  ] Finished Load Kernel Module fuse.
[FAILED] Failed to start Load Kernel Modules.
See 'systemctl status systemd-modules-load.service' for details.
[  OK  ] Finished Generate network units from Kernel command line.
[  OK  ] Finished Remount Root and Kernel File Systems.
         Mounting Kernel Configuration File System...
         Starting Flush Journal to Persistent Storage...
         Starting Apply Kernel Variables...
         Starting Create Static Device Nodes in /dev...[    3.206617]
systemd-journald[124]: Received client request to flush runtime journal.

[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Finished Flush Journal to Persistent Storage.
[  OK  ] Finished Apply Kernel Variables.
[  OK  ] Finished Create Static Device Nodes in /dev.
[  OK  ] Reached target Preparation for Local File Systems.
         Mounting /tmp...
         Mounting /var/volatile...
[    3.338366] audit: type=1334 audit(1651167746.684:2): prog-id=5 op=LOAD
[    3.345166] audit: type=1334 audit(1651167746.688:3): prog-id=6 op=LOAD
         Starting Rule-based Manage…for Device Events and Files...
[  OK  ] Mounted /tmp.
[  OK  ] Mounted /var/volatile.
         Mounting /var/volatile/tmp...
         Starting Load/Save Random Seed...
[  OK  ] Mounted /var/volatile/tmp.
[  OK  ] Reached target Local File Systems.
         Starting Create Volatile Files and Directories...
[  OK  ] Finished Create Volatile Files and Directories.
         Starting Network Time Synchronization...
         Starting Record System Boot/Shutdown in UTMP...
[  OK  ] Started Rule-based Manager for Device Events and Files.
[  OK  ] Finished Coldplug All udev Devices.
[  OK  ] Finished Record System Boot/Shutdown in UTMP.
[  OK  ] Started Network Time Synchronization.
[  OK  ] Reached target System Initialization.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target System Time Set.
[  OK  ] Started Daily rotation of log files.
[  OK  ] Reached target Timer Units.
[  OK  ] Listening on D-Bus System Message Bus Socket.
         Starting sshd.socket...
[  OK  ] Listening on sshd.socket.
[  OK  ] Reached target Socket Units.
[  OK  ] Reached target Basic System.
[  OK  ] Started Job spooling tools.
[  OK  ] Started Periodic Command Scheduler.
         Starting D-Bus System Message Bus...
         Starting IPv6 Packet Filtering Framework...
         Starting IPv4 Packet Filtering Framework...
[  OK  ] Started irqbalance daemon.
[  OK  ] Started Hardware RNG Entropy Gatherer Daemon.
[  OK  ] Started System Logging Service.
         Starting Resets System Activity Logs...
[    4.124453] audit: type=1334 audit(1651254541.860:4): prog-id=7 op=LOAD
[    4.131266] audit: type=1334 audit(1651254541.868:5): prog-id=8 op=LOAD
         Starting User Login Management...
         Starting OpenSSH Key Generation...
[  OK  ] Finished IPv6 Packet Filtering Framework.
[  OK  ] Finished IPv4 Packet Filtering Framework.
[  OK  ] Reached target Preparation for Network.
         Starting Network Configuration...
[  OK  ] Finished Resets System Activity Logs.
[  OK  ] Finished OpenSSH Key Generation.
[  OK  ] Started Network Configuration.
         Starting Network Name Resolution...
[  OK  ] Started Network Name Resolution.
[  OK  ] Reached target Network.
[  OK  ] Reached target Host and Network Name Lookups.
[  OK  ] Started Netperf Benchmark Server.
[  OK  ] Started NFS status monitor for NFSv2/3 locking..
[  OK  ] Started Respond to IPv6 Node Information Queries.
[  OK  ] Started Network Router Discovery Daemon.
         Starting Permit User Sessions...
[  OK  ] Started Xinetd A Powerful Replacement For Inetd.
[  OK  ] Finished Permit User Sessions.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttyLF0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Created slice Slice /system/systemd-fsck.
[  OK  ] Found device /dev/mmcblk0p1.
         Starting File System Check on /dev/mmcblk0p1...
[  OK  ] Finished File System Check on /dev/mmcblk0p1.
         Mounting /run/media/boot_s32g3-mmcblk0p1...
[  OK  ] Mounted /run/media/boot_s32g3-mmcblk0p1.
[  OK  ] Finished Load/Save Random Seed.
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started User Login Management.
[  OK  ] Reached target Multi-User System.
         Starting Record Runlevel Change in UTMP...
[  OK  ] Finished Record Runlevel Change in UTMP.


Regards,
Ghennadi


