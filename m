Return-Path: <linux-mmc+bounces-6643-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC695AC0340
	for <lists+linux-mmc@lfdr.de>; Thu, 22 May 2025 05:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E12717ED8D
	for <lists+linux-mmc@lfdr.de>; Thu, 22 May 2025 03:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80441155382;
	Thu, 22 May 2025 03:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QdTL68TG"
X-Original-To: linux-mmc@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35464D;
	Thu, 22 May 2025 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747886392; cv=fail; b=nyGwtwLb4Duu5tAU5t8JBf7JyFKpMnERFVv5XBFZRcOwSpti3+pjMGdujmIPOTCObWNKa+CP6oxWKUwsedxfBAr5c4g38iXApcN5rdiJq047OkwcjwvHtwSCAjrlH6buUvs2OE94u6TrYaGcbxr6EE2xE4M54u8huklzIjHia6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747886392; c=relaxed/simple;
	bh=+1HmQkrzihsC+YDIZeXoKhTKEqNy4eZ6rV83n4uuiC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qNPfzreakiLo2qcPy9ChvNG2MJe52+TuIH22e4FCmNUwVQykOfQS+EFoN7GMGmhfnis3/V2mAfbmMvLs9h0jtnvQy07QoTlAyhSixNb9RTc+n4/sPeSp8AnbONIM7q7kU0Q0X+q0aVl0WH7rsjYsGaX1l23VaY9RJpbh8brM43w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QdTL68TG; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufznxThzrFMezxuLWD7oNOsCthqQcTCQSo0h3FeDYEKgvKRWO6Ry6RRpKrPFXB3kU/ySAbmrJa6NGyFcunXFPt9+pI0ByXQR0Gvkz5GYZaXD2vKO/VW8Kbd0Ch3c5w6XI/VmCOfa9/wR8P+5mJu6fcoeUOIXr8Sntdc+9Qqm841vsQ6qxnr3MNMbHuY0zlGDx/AJJk4Q10Lgg4snv2hQBTRQX7h+edKbmL9gh3a+5tL0RF6B03AckDfTCce84vM8i1xfRaeTS3YVIZHLKunf0or62I0vgvR7Q20wkzUVsph+dnJOB2JhpNrzTTONnHmIR+ahjyywKxCCDOtKh4s3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1HmQkrzihsC+YDIZeXoKhTKEqNy4eZ6rV83n4uuiC8=;
 b=v2+KM8lnMF7z3s6HSa/VLLrc9IBy/4Uv2RHBXTbLA6tCCTsiBEMrZ2Xs3IAXj4gQvJU8zLdNyHokwn+i19tFnN5PjcmGlqwf7xFxjHhyvoluy6bTJfBzdTBQk5Gvt1gRCSBOcYDXffYpD9rtlbRqCzKHN49TDUF60WforVY1FgyJIZc7aWkcOnJgR7kI+RSPjcUtlsJCL/0626z1CpCaFrtFAXSb4QGyj6eqONNZxqrWPlMkbKz4JvDEr5UO+8lXORVGmElkFkASlTFF2g6PbmYmNSnihSwv72LJew4/bbL6u5kyE7swMD+7Pkb8nujq4fDf0A1Inj9uR6qNpfK1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1HmQkrzihsC+YDIZeXoKhTKEqNy4eZ6rV83n4uuiC8=;
 b=QdTL68TG4cDlMXLAqO/iIkmh1hyvU0AH2mD2Q8EHMtAu84Fl77dhGiRHaSOnLYjBA0idaS11AzcuYQBp5nKSKfogsZ8wPRNA8hTQfSnnv0V6grOecst1wZNDk4cWhYFeQc1Xh0x7UvcFdz13CXDjxjZd6eoM00xBi7HpMZ1WCCp9mztGCVxF1sk0jg4EFukshJcaPbbX9Un5eKChqsaB17q0UgmdKxkOFf3BcD/uab1nTiaVGrTJ1pujhw1dKIjaOoOqLQSmyEtFsje1AS2i08G36jd4Th9a1Rx23CHRDuw7Zq8XLGeGS0FrgILknRSGn9kOgJPYC8evLgQsNH9yCg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 03:59:45 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8722.031; Thu, 22 May 2025
 03:59:45 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Frank Li <frank.li@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: sdhci-esdhc-imx: refactor clock loopback
 selection logic
Thread-Topic: [PATCH 1/2] mmc: sdhci-esdhc-imx: refactor clock loopback
 selection logic
Thread-Index: AQHbyfuQsFFBLvMC+ku2qRP90LQjVbPdQZwAgADA8kCAAAUcgA==
Date: Thu, 22 May 2025 03:59:45 +0000
Message-ID:
 <DU0PR04MB9496FAD97EF4557F369E218C9099A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
 <aC360rN4h3smTAj7@lizhi-Precision-Tower-5810>
 <DU0PR04MB9496789260A17A03E711A7399099A@DU0PR04MB9496.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB9496789260A17A03E711A7399099A@DU0PR04MB9496.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PA4PR04MB7709:EE_
x-ms-office365-filtering-correlation-id: 4190e139-96ee-4d11-cd02-08dd98e516b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?dytBa2NnNENRNXhicmhpR3ZjUVFIaVB4Y1RKOVpmM3M5ZHVQQVUzV2NzYlNi?=
 =?gb2312?B?dGxtdUxwSEJEZ2xIT3J3Y3FlREE4OXR5SUEyUUwrMzJBaEEraWZBdGdkRVNw?=
 =?gb2312?B?UXA4ZHVseURIWmhYdXdKT0ptbDVpb0hJQ3ZnZzBjVVJPWFFSZWpiRzc5MmNm?=
 =?gb2312?B?NzZzc2FMT1dEL1pzenNjNFZsOWFFOVZsSFFIZU83U1BpLzQ2ZWhpRjBkMDU0?=
 =?gb2312?B?SzUyUnlBd0hZbmtiWWo1dG5nc2xsWXNPVnR4cXpBY3pneVdCeXNKbU5SNXFO?=
 =?gb2312?B?eTR3czcvWGRtd2lnT0Qxa1pVWld1VWoydUEyanA1aTQyNkN5U0xzdjRSRmdD?=
 =?gb2312?B?ekNSZzV5b1haVVAzNFJiR0U1ZVVhQTdIT1FTSFRpZHd2YmovdnQweENFUnZE?=
 =?gb2312?B?ZXdJN0VHRzBnTmFVTkFGRFpuanRLL2Urc0krak0xbkF2eEFPbVR3ZGdQQmhQ?=
 =?gb2312?B?SEZkZmhtRndqSlNMd0lRSkhIL1BWeUVVMjRQWUt3ZzF1QUNvTnpTd05CUjJF?=
 =?gb2312?B?WmR0RnpRb0VXNWpJUklmT0tzUUdFVW1yWWwvMkFwTGJqV1o5d3RlQXVmMkVS?=
 =?gb2312?B?YjZqMzAvaGFGVDZkQkZTeDBwRzJMdm5OS0pkdzZRazRRMWh2Tjl1Nm1XYmZp?=
 =?gb2312?B?a29SVU16K1RHUjRIMEdKbjVzNFQya1ZLenBGVDV5L04zVWJSaFUrdC9xMEJi?=
 =?gb2312?B?QzkxYlFHUFJJNWxMOHk1bHQwOFZjZFhTM1VMUVcwaDFmRWJqTDJucFdickU1?=
 =?gb2312?B?T0tZR1V5Y0pDUDNmNEJoazZrL1VhUXRKWmcwMFk2dWdEMDFUL0huWG1oRHUx?=
 =?gb2312?B?YjFTdmpmU29uM3ZpdExLMWRyT0RtQjExTGl5OU9tSUV4TGNDeFlDaVhTMzJp?=
 =?gb2312?B?YmFNRE5pZ2xNYi9za1huZiszZStFU2lnM1JXemlMdDM2SEdEK25zMnhKczht?=
 =?gb2312?B?VnhwZkw2NVc2NHNvcCtGOThwUFdQTUVKcGtKcm9CVGJXRkVqa2E1SDVVZzRt?=
 =?gb2312?B?WDhPSHFFT3pBOEZiTlpUWkVsNE54MDRoQkxCdURFbVlPcVg5MW5ROVlvMFZk?=
 =?gb2312?B?NDBONlU1SGtsaXFvejhQYy9xQk5XL3orakx5aW9odEJxOTlmdjFVNzEvUG1a?=
 =?gb2312?B?MmdOWVVVc2kvUnhQVmZOemZwUW9Xam5rY0dQRE5kZ3BPdEZrZjdWeW1jeEMr?=
 =?gb2312?B?b0dvTUJqeS9WVUZUdk5GLythbjQ3aGxmOXpOUEZTZ3dmMkRtb1hJdU1HQk5r?=
 =?gb2312?B?R1lyRjNqQ3dNaG4yK2tpbndEZDViWmhFbUR0bFNXOFgxcDJScHZ0ekpDWSt2?=
 =?gb2312?B?V0kxaEhjRDdDc0Z6NE5YZERFWWlCc0FQbWF2eW45U2FyeUx2ZDlQOFhycWVJ?=
 =?gb2312?B?UmsrbGRVZDV3REdKa0hrck1MakpTL04zZGttNDUxYmpsRkZ1Z09ONGtGUGVq?=
 =?gb2312?B?UzJVQ09BdzdFUlJDWGpyZnNrM2dITXlaRGU2emVEMlZKcHNLR3lSYlhLZ0dr?=
 =?gb2312?B?eDdEdEMxdWV1ZlExMHJaSlA2Qmk1Z0hCYU5QV0YwOVFoWGxRVEZ2a2pEbm5G?=
 =?gb2312?B?YVdwMlVnb0tqNURYb0d4aUpXRHN0SmJzVUZxUTdRQkpNcERJUElTQnUwR0NY?=
 =?gb2312?B?NWp1U0xCN3ErT3p1RWdiM3VxdkxvVlorby95MVNlQWlYOUJrT3ZkNmFneGdN?=
 =?gb2312?B?WFdMT296b1g1cnJ1eHlHUDZyL2ppU09qWi93TURhbXR5NzEvUHMxMmxnWUVs?=
 =?gb2312?B?ZTBrZzNPOVl5Qkd1SkE5bVA5aGNWdkJiTFdMdTJNTkFkZWxpU2dvUXBOakR2?=
 =?gb2312?B?enFyOEIyRHJvdVNTWGF0RzVBb0YwdkQzY0dvVi9FYUNPWTVBNGhyNTVFZVVJ?=
 =?gb2312?B?YkIraDQySGVIOUl6V1B0TGx5RGdjdHo3Y0FYVWZvZ0FJaW02MGFhc3NoMCth?=
 =?gb2312?B?MHFYditOUXVLSGhRNGVvenEwajJnWFgrOVRBekd1VW1GbmhsOUVFOWM5Wi82?=
 =?gb2312?B?ZmVXTTJNdi93PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cjFXQy9GS1J6TDl6YzdNY0NEbTZvamF4VkswS1hTOEg0Rk5Wc1JvYlJPQStX?=
 =?gb2312?B?clR2MmlobTVHR01kaGtGTnEvemNMbVdqUUdpSEpxeldXS3pweFcvbE1Yd0VP?=
 =?gb2312?B?eUlVRTFsbWJUWFZzT0xCVUZZbmlidDR1bnFRMzV3RzljMDZLZ09kNUtOMVBY?=
 =?gb2312?B?aW9IN0wzbU96Y3NPNUJrQ1U1NWgrTDNFeEZNckoxN3FWVlZjQ01LSmdtVTRW?=
 =?gb2312?B?SDN5RFQrNTE0Yk4yc2FBSXA1TExkSEMzdndZYUM1eGtTQ3VWWlNUaEhnR21B?=
 =?gb2312?B?MWNjOGRCY0xkNXZObHRreGJ4R2hhSFlYVnZZZExBSVV0NndUVE5aUDgxM0tj?=
 =?gb2312?B?UTZUaFM4b1E5NHkzcitxVXVsM3ozMTdFSUdSektMblFBTVUyMjRSa0JFTEpv?=
 =?gb2312?B?WnVvbS9uNERQaVZsN3l6NVl5U1I3NFpJS01sOHhRK1E0ZlFkc0RFVEtBUDIx?=
 =?gb2312?B?TXpSWkRlNzdFWHc2dW5nTm5BQ09xeFhwWmFGUnJkSEJ1LzVDU1hMc3RCazRG?=
 =?gb2312?B?Skc2SXNGdU5mZEhUNXNWN3QzdUhmZDgrSDFNOGZuSHpGdXRhZTNmZ0tJUHFI?=
 =?gb2312?B?ZlcyN1gvMVBMTURHbHdzdFViRFJVQXEvUU1Udm9nWHpnMUhoVEk1RDJsZ214?=
 =?gb2312?B?ZUpBWmlqaTdVS212dnNkZzhWWE8xRzMzdjd5ZFh0a1lObkhUeGJrMEk3N05h?=
 =?gb2312?B?OW1xWlJKb3E1elFxMXhNNVFkUDBtWjZpRlFBRnFxUDkvTDNjYytZbnltMmhQ?=
 =?gb2312?B?SHRDZTRVVWFLY1hxK0k3OHlyTTlCYjg0bzRuZDZVS1VHY09rbVhsYlM0YzFx?=
 =?gb2312?B?S0dmYmVLWVpTUXdQOUpBNEVxSVRqM0NHZUhLT2FvdGpGb2ZCalJsNS9YV01X?=
 =?gb2312?B?U2FFcVU2M2lzWGJaQSs0STVPbnVya2FPTzZEMVJRQjh1dVVxVVRIaUdEdFIy?=
 =?gb2312?B?Njc1YjhnZTBOSmsrSDFIc3RocUZ3MlUyUXZQZC8vNDg5Q2NSc3ozMVlITkQ5?=
 =?gb2312?B?RUhCcG4vT0xHL3hxN1BxUnVjQy9teWJyNUplaVpyVG9NZ0wxNGJWZ01wZndv?=
 =?gb2312?B?b0VaN1hBbjF4RTJxTU9kRE9USDYrZTFQMWs1eEMxV1ROSVMwREF3TWdkM1pu?=
 =?gb2312?B?UzJheGlRUGx6TGJYS3VRQ3lMZEhIdE5YcTk0bXpqYzU4UWc2d1d5UVJnSUgw?=
 =?gb2312?B?bGh1OENJR0ZYZXZoVEJuQjRiMDQwM25SM0pOc1ZtU2ZoTGVPeHQ3RXhZUmpT?=
 =?gb2312?B?Vld4WUZUdGl0WTFoWEhwYnhSYlJOczVFZm5TdkNTd2ErNmd0Y201TjlkcHpq?=
 =?gb2312?B?Z0lHenNSNEJOQkY5QjZkSHVrOGtIWDlVMi9hazNoenBreVFWVFVETGU3Wjdz?=
 =?gb2312?B?UGVGZ2d6MXBTZmIvWFhIMlgya0E4MjhIWVBmR0g4c1AvM0FtZ0plVnp1cXBQ?=
 =?gb2312?B?cSt3dzZrMFYxS1NlNHAvaXppV2VGTWRMcjd3cGt0VlJwMC9MWDlLZUgxM0lq?=
 =?gb2312?B?VGppVUlCc2dpMC83enZGdU45Ujh6aXR2M0pxTENlNC82UmtNRG0vOTZiWVpR?=
 =?gb2312?B?ZkkySWV2NzhSOTgyNjVSQWlJN3o3RXNqMVRmSlkzUll5dzk0SmhkOXh0dExQ?=
 =?gb2312?B?RjJtaHNOU2VQdkVnN3ljRU5qQVBGb2d6TElqUXNQMkhadlVwWHZrVXEwMUVz?=
 =?gb2312?B?SlpxZForbG5kUFFXTkNFTFdEUGFrNmU3WVFTZ2RjTFh6NDNkb0pBak9HU1JH?=
 =?gb2312?B?VFRuWksyLzBmTzlzbk8zcTdlNTRwYjd3T2JLNXNIMlZ6WDh1bzF1ZTkrRm1S?=
 =?gb2312?B?M3p1WU02dU1PdzkvTVBlYUViTlZINnBNazZaUXRnUkYwR2NhWGQ4SkNFaElr?=
 =?gb2312?B?bXNsWWxNd3JoaUV5bm50WWF5ZnBZSm85ZjJoZjR6Vk8rRnRhZTdKUDhUZVVB?=
 =?gb2312?B?Z3RrcUZNb2ZrYU1Hb1ZIbWdhRzRDQkdXaE1JZzI4TG9uaEdXMU5MMkp6NFRy?=
 =?gb2312?B?V29YTkFqWkE2SXozV3MvQXJEMlpDUnVyMXNTZTcrdnh5VzA5bnprcW9uZlZK?=
 =?gb2312?B?WnEzQ2hoN3lSWE5kdzErUzVCWlA5V2s2Tk1WQ1NoSXh0TkNCWlNIeVY2N0hY?=
 =?gb2312?Q?kniY=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4190e139-96ee-4d11-cd02-08dd98e516b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:59:45.2005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPqz1Z7fdAhpaCDXdnXHkRIxx3KZZrVPhPDvm8VzW7WZTIy/oJdSZyiUEGiBkFOcyIArlo9Z6lV1rDuC89yxkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7709

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3VnaCBDaGVuDQo+IFNlbnQ6
IDIwMjXE6jXUwjIyyNUgMTE6NTMNCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsg
THVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT4NCj4gQ2M6IGFkcmlhbi5odW50ZXJAaW50
ZWwuY29tOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRl
djsgZGwtUzMyDQo+IDxTMzJAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTog
W1BBVENIIDEvMl0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IHJlZmFjdG9yIGNsb2NrIGxvb3BiYWNr
DQo+IHNlbGVjdGlvbiBsb2dpYw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiA+IFNlbnQ6IDIwMjXE6jXU
wjIyyNUgMDoxMA0KPiA+IFRvOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiA+
IENjOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBhZHJpYW4uaHVudGVyQGludGVs
LmNvbTsNCj4gPiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnOw0KPiA+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsNCj4gPiBmZXN0ZXZhbUBnbWFpbC5jb207IGlteEBsaXN0cy5s
aW51eC5kZXY7IGRsLVMzMiA8UzMyQG54cC5jb20+Ow0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8yXSBtbWM6IHNkaGNpLWVzZGhjLWlteDogcmVmYWN0b3IgY2xvY2sg
bG9vcGJhY2sNCj4gPiBzZWxlY3Rpb24gbG9naWMNCj4gPg0KPiA+IE9uIFdlZCwgTWF5IDIxLCAy
MDI1IGF0IDEwOjU1OjAxQU0gKzA4MDAsIHppbml1LndhbmdfMUBueHAuY29tIHdyb3RlOg0KPiA+
ID4gRnJvbTogTHVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBp
Lk1YIHJlZmVyZW5jZSBtYW51YWwgc3BlY2lmaWVzIHRoYXQgaW50ZXJuYWwgY2xvY2sgbG9vcGJh
Y2sgc2hvdWxkDQo+ID4gPiBiZSB1c2VkIGZvciBTRFIxMDQvSFMyMDAvSFM0MDAgbW9kZXMuIE1v
dmUNCj4gRVNESENfTUlYX0NUUkxfRkJDTEtfU0VMDQo+ID4gPiBjb25maWd1cmF0aW9uIGludG8g
dGhlIHRpbWluZyBzZWxlY3Rpb24gZnVuY3Rpb24gdG86DQo+ID4gPg0KPiA+ID4gMS4gRXhwbGlj
aXRseSBzZXQgaW50ZXJuYWwgbG9vcGJhY2sgcGF0aCBmb3IgU0RSMTA0L0hTMjAwL0hTNDAwDQo+
ID4gPiBtb2RlcyAyLiBBdm9pZCByZWR1bmRhbnQgYml0IG1hbmlwdWxhdGlvbiBhY3Jvc3MgbXVs
dGlwbGUgZnVuY3Rpb25zDQo+ID4gPg0KPiA+ID4gUHJlc2VydmUgRVNESENfTUlYX0NUUkxfRkJD
TEtfU0VMIGR1cmluZyBzeXN0ZW0gcmVzdW1lIGZvciBTRElPDQo+ID4gPiBkZXZpY2VzIHdpdGgg
TU1DX1BNX0tFRVBfUE9XRVIgYW5kIE1NQ19QTV9XQUtFX1NESU9fSVJRIGZsYWcsDQo+ID4gYXMg
dGhlDQo+ID4gPiBjb250cm9sbGVyIG1pZ2h0IGxvc2UgcmVnaXN0ZXIgc3RhdGUgZHVyaW5nIHN1
c3BlbmQgd2hpbGUgc2tpcHBpbmcNCj4gPiA+IGNhcmQgcmUtaW5pdGlhbGl6YXRpb24uDQo+ID4N
Cj4gPiB3aGF0J3MgbWVhbnM/DQo+ID4NCj4gPiBjb250cm9sbGVyIGxvc3QgcG93ZXIgZHVyaW5n
IHN1c3BlbmQsIHNvDQo+ID4gdTMyIG0gPSByZWFkbChob3N0LT5pb2FkZHIgKyBFU0RIQ19NSVhf
Q1RSTCkgdG8gZ2V0IHJlc2V0IHZhbHVlIGFuZA0KPiA+IG1pc3MNCj4gPg0KPiA+IHNldCB+RVNE
SENfTUlYX0NUUkxfRkJDTEtfU0VMPw0KPiANCj4gTWlzcyBzZXQgRVNESENfTUlYX0NUUkxfRkJD
TEtfU0VMLg0KPiANCj4gUHJldmlvdXMgU0RJTzMuMCBkZXZpY2Ugd2l0aCBNTUNfUE1fS0VFUF9Q
T1dFUiB3aWxsIHNldA0KPiBFU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUwsIEFmdGVyIHN5c3RlbSBy
ZXN1bWUsIG5lZWQgdG8gcmUtY29uZmlnDQo+IEVTREhDX01JWF9DVFJMX0ZCQ0xLX1NFTC4gQnV0
IFNESU8zLjAgZGV2aWNlIHdpdGgNCj4gTU1DX1BNX0tFRVBfUE9XRVIgd2lsbCBub3QgcmUtaW5p
dGlhbGl6YXRpb24sIGJ1dCB3aWxsIGNhbGwgc2V0X2lvcy0+DQo+IHNldF91aHNfc2lnbmFsaW5n
KCkuDQoNCnNkaGNfZXNkaGNfdHVuaW5nX3Jlc3RvcmUoKSB3aWxsIGFsc28gc2V0IGJhY2sgdGhl
IEVTREhDX01JWF9DVFJMX0ZCQ0xLX1NFTC4uDQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+
IFJlZ2FyZHMNCj4gSGFpYm8gQ2hlbg0KPiA+DQo+ID4gRnJhbmsNCj4gPg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMjcgKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktZXNkaGMtaW14LmMNCj4gPiA+IGluZGV4IDc2MTE2ODJmMTBjMy4uYzQ0OGE1MzUzMGE1IDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+
ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ID4gQEAgLTcy
OCwyMyArNzI4LDE3IEBAIHN0YXRpYyB2b2lkIGVzZGhjX3dyaXRld19sZShzdHJ1Y3Qgc2RoY2lf
aG9zdA0KPiA+ICpob3N0LCB1MTYgdmFsLCBpbnQgcmVnKQ0KPiA+ID4gIAkJd3JpdGVsKG5ld192
YWwsIGhvc3QtPmlvYWRkciArIEVTREhDX1ZFTkRPUl9TUEVDKTsNCj4gPiA+ICAJCWlmIChpbXhf
ZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX1NURF9UVU5JTkcpIHsNCj4gPiA+ICAJ
CQl1MzIgdiA9IHJlYWRsKGhvc3QtPmlvYWRkciArIFNESENJX0FVVE9fQ01EX1NUQVRVUyk7DQo+
ID4gPiAtCQkJdTMyIG0gPSByZWFkbChob3N0LT5pb2FkZHIgKyBFU0RIQ19NSVhfQ1RSTCk7DQo+
ID4gPiAtCQkJaWYgKHZhbCAmIFNESENJX0NUUkxfVFVORURfQ0xLKSB7DQo+ID4gPiArCQkJaWYg
KHZhbCAmIFNESENJX0NUUkxfVFVORURfQ0xLKQ0KPiA+ID4gIAkJCQl2IHw9IEVTREhDX01JWF9D
VFJMX1NNUENMS19TRUw7DQo+ID4gPiAtCQkJfSBlbHNlIHsNCj4gPiA+ICsJCQllbHNlDQo+ID4g
PiAgCQkJCXYgJj0gfkVTREhDX01JWF9DVFJMX1NNUENMS19TRUw7DQo+ID4gPiAtCQkJCW0gJj0g
fkVTREhDX01JWF9DVFJMX0ZCQ0xLX1NFTDsNCj4gPiA+IC0JCQl9DQo+ID4gPg0KPiA+ID4gLQkJ
CWlmICh2YWwgJiBTREhDSV9DVFJMX0VYRUNfVFVOSU5HKSB7DQo+ID4gPiArCQkJaWYgKHZhbCAm
IFNESENJX0NUUkxfRVhFQ19UVU5JTkcpDQo+ID4gPiAgCQkJCXYgfD0gRVNESENfTUlYX0NUUkxf
RVhFX1RVTkU7DQo+ID4gPiAtCQkJCW0gfD0gRVNESENfTUlYX0NUUkxfRkJDTEtfU0VMOw0KPiA+
ID4gLQkJCX0gZWxzZSB7DQo+ID4gPiArCQkJZWxzZQ0KPiA+ID4gIAkJCQl2ICY9IH5FU0RIQ19N
SVhfQ1RSTF9FWEVfVFVORTsNCj4gPiA+IC0JCQl9DQo+ID4gPg0KPiA+ID4gIAkJCXdyaXRlbCh2
LCBob3N0LT5pb2FkZHIgKyBTREhDSV9BVVRPX0NNRF9TVEFUVVMpOw0KPiA+ID4gLQkJCXdyaXRl
bChtLCBob3N0LT5pb2FkZHIgKyBFU0RIQ19NSVhfQ1RSTCk7DQo+ID4gPiAgCQl9DQo+ID4gPiAg
CQlyZXR1cm47DQo+ID4gPiAgCWNhc2UgU0RIQ0lfVFJBTlNGRVJfTU9ERToNCj4gPiA+IEBAIC0x
MDgyLDcgKzEwNzYsNiBAQCBzdGF0aWMgdm9pZCBlc2RoY19yZXNldF90dW5pbmcoc3RydWN0DQo+
ID4gPiBzZGhjaV9ob3N0DQo+ID4gKmhvc3QpDQo+ID4gPiAgCQljdHJsICY9IH5FU0RIQ19NSVhf
Q1RSTF9BVVRPX1RVTkVfRU47DQo+ID4gPiAgCQlpZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdz
ICYgRVNESENfRkxBR19NQU5fVFVOSU5HKSB7DQo+ID4gPiAgCQkJY3RybCAmPSB+RVNESENfTUlY
X0NUUkxfU01QQ0xLX1NFTDsNCj4gPiA+IC0JCQljdHJsICY9IH5FU0RIQ19NSVhfQ1RSTF9GQkNM
S19TRUw7DQo+ID4gPiAgCQkJd3JpdGVsKGN0cmwsIGhvc3QtPmlvYWRkciArIEVTREhDX01JWF9D
VFJMKTsNCj4gPiA+ICAJCQl3cml0ZWwoMCwgaG9zdC0+aW9hZGRyICsgRVNESENfVFVORV9DVFJM
X1NUQVRVUyk7DQo+ID4gPiAgCQl9IGVsc2UgaWYgKGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAm
DQo+IEVTREhDX0ZMQUdfU1REX1RVTklORykNCj4gPiB7IEBADQo+ID4gPiAtMTE3Nyw4ICsxMTcw
LDcgQEAgc3RhdGljIHZvaWQgZXNkaGNfcHJlcGFyZV90dW5pbmcoc3RydWN0DQo+ID4gPiBzZGhj
aV9ob3N0DQo+ID4gKmhvc3QsIHUzMiB2YWwpDQo+ID4gPiAgCQkid2FybmluZyEgUkVTRVRfQUxM
IG5ldmVyIGNvbXBsZXRlIGJlZm9yZSBzZW5kaW5nIHR1bmluZw0KPiA+ID4gY29tbWFuZFxuIik7
DQo+ID4gPg0KPiA+ID4gIAlyZWcgPSByZWFkbChob3N0LT5pb2FkZHIgKyBFU0RIQ19NSVhfQ1RS
TCk7DQo+ID4gPiAtCXJlZyB8PSBFU0RIQ19NSVhfQ1RSTF9FWEVfVFVORSB8IEVTREhDX01JWF9D
VFJMX1NNUENMS19TRUwgfA0KPiA+ID4gLQkJCUVTREhDX01JWF9DVFJMX0ZCQ0xLX1NFTDsNCj4g
PiA+ICsJcmVnIHw9IEVTREhDX01JWF9DVFJMX0VYRV9UVU5FIHwNCj4gRVNESENfTUlYX0NUUkxf
U01QQ0xLX1NFTDsNCj4gPiA+ICAJd3JpdGVsKHJlZywgaG9zdC0+aW9hZGRyICsgRVNESENfTUlY
X0NUUkwpOw0KPiA+ID4NCj4gPiAJd3JpdGVsKEZJRUxEX1BSRVAoRVNESENfVFVORV9DVFJMX1NU
QVRVU19ETFlfQ0VMTF9TRVRfUFJFX01BUw0KPiA+IEssIHZhbCksDQo+ID4gPiAgCSAgICAgICBo
b3N0LT5pb2FkZHIgKyBFU0RIQ19UVU5FX0NUUkxfU1RBVFVTKTsgQEAgLTE0MzIsNg0KPiA+ICsx
NDI0LDE1DQo+ID4gPiBAQCBzdGF0aWMgdm9pZCBlc2RoY19zZXRfdWhzX3NpZ25hbGluZyhzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCwNCj4gPiA+IHVuc2lnbmVkDQo+ID4gdGltaW5nKQ0KPiA+ID4g
IAkJYnJlYWs7DQo+ID4gPiAgCX0NCj4gPiA+DQo+ID4gPiArCWlmICh0aW1pbmcgPT0gTU1DX1RJ
TUlOR19VSFNfU0RSMTA0IHx8DQo+ID4gPiArCSAgICB0aW1pbmcgPT0gTU1DX1RJTUlOR19NTUNf
SFMyMDAgfHwNCj4gPiA+ICsJICAgIHRpbWluZyA9PSBNTUNfVElNSU5HX01NQ19IUzQwMCkNCj4g
PiA+ICsJCW0gfD0gRVNESENfTUlYX0NUUkxfRkJDTEtfU0VMOw0KPiA+ID4gKwllbHNlDQo+ID4g
PiArCQltICY9IH5FU0RIQ19NSVhfQ1RSTF9GQkNMS19TRUw7DQo+ID4gPiArDQo+ID4gPiArCXdy
aXRlbChtLCBob3N0LT5pb2FkZHIgKyBFU0RIQ19NSVhfQ1RSTCk7DQo+ID4gPiArDQo+ID4gPiAg
CWVzZGhjX2NoYW5nZV9waW5zdGF0ZShob3N0LCB0aW1pbmcpOyAgfQ0KPiA+ID4NCj4gPiA+IC0t
DQo+ID4gPiAyLjM0LjENCj4gPiA+DQo=

