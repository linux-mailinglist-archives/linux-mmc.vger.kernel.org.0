Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599557E2C9B
	for <lists+linux-mmc@lfdr.de>; Mon,  6 Nov 2023 20:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjKFTGL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 Nov 2023 14:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjKFTGK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2023 14:06:10 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB2125
        for <linux-mmc@vger.kernel.org>; Mon,  6 Nov 2023 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699297567; x=1730833567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jwZRMqpVWpIZQP65h0BVXp5lX9po7G5MagT15PMCgbg=;
  b=SHFdC81NeIhrJEuy27WEjV+7d82o9T317rK8VT7b+WY8SZwn/6paiW5T
   wKYXN1JhnuMSag/umsXdY5RQ/89AVjK339dGBydykIeu7uT6N72ZX2LLv
   n8oN0SJu7DKnOhMDkQn5rFNIZNVZaq785v939gDNaUjESkpM22juoyTmz
   Sm9Wt7jBXoxr5W2GCSzosrL9urVJOOpmw6+0tH+ff0rMneMuABKf/PyK9
   dLZoerX0Xcw40vzXQc0D1bTMCPVfdck3MyY+lrcaZySSYIPUA0rOgoMI/
   9r1Xn5U3AybSUHBDYbBk6LJckOlJ7NJoADp1Y9DYtOWUr/bYyYczLcRll
   A==;
X-CSE-ConnectionGUID: iuE0UZm5RkWPaaVqSyX83w==
X-CSE-MsgGUID: 6CL4VMyDSRCjI9hUjJkkEQ==
X-IronPort-AV: E=Sophos;i="6.03,282,1694707200"; 
   d="scan'208";a="1483902"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2023 03:06:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4c7CR2FCe7No1jL+AgyoZyljsZOpDmBZhgx+EDFczaYripQMlfBd+hD/ptCKG6/bMa5nvj29yfbtujGaMSi9Mv02o8BK8SIevyqVOCk6l4Rxhd9XoTES4XaUjS9Nv5wXBYOQ+/r+qfNmZFB6twGsiaEkxtd3gO2QThtemx5pCrDetmhD6mtkHX3PwHZMTbgXQNKEDxSUtKacrzy3fAb5J5kBxooZZ80iHmGdUBvlrCNhxq2bvKxDLP5sKZHgziFwTmkjD/FArVmzaXxqdcdDsajumF+C6ZJflHY4nuxrN5LR2vzhoe7ytNUfOFjsuo9PDeI0kwc7zm5mS+VXlYWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwZRMqpVWpIZQP65h0BVXp5lX9po7G5MagT15PMCgbg=;
 b=bJagsrq/cpXCCEp/FKeG4AT7zBoJ8e2M2ET1MfcoqdWZ2q1/WDZAdVMaWyw2d0o21wQo9WVyeIXHGcSF88SDMm+XWJ1KEJbPhIJ7bcmsMqrAafUJkNOufBNy13oZjv0stSg5slvRT/eDZ0a0Ih8b/vj9M8a/42MtqxGNXPYp1vsBGrD56g0gAu090f7L5zUrUV90eguMuADZiM/m96lSyd2zFhjrtZRnsPPF5IXT7qX/dGEYuqVitJsnQi8zrc25DjsViruOWzCphhBT+FSbsS8YVEU9cQyg/KxNNh27zZ7tS+X3v66NtiRVxLqGVigHYHB5KEqsZ8W55FLOTUyKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwZRMqpVWpIZQP65h0BVXp5lX9po7G5MagT15PMCgbg=;
 b=QiZoSeitkPBNGnOIalhYliFszyRFizxFLcAqriQ4CkIpljf4UTMG/lhmPFGL2HAe/q3sSqUCaaxqrXozMDuuxwp1AhGc2xyXCOCi2bXDx7VviXmuhZ18LzH4hT2ZwDfr8fEr7dtFOFmLUXpGNRE6UeHLOWPaIz7yYvnG3Bqfu0o=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by PH0PR04MB7288.namprd04.prod.outlook.com (2603:10b6:510:1f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 19:06:03 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::d696:a2fb:221a:1f02]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::d696:a2fb:221a:1f02%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 19:06:03 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Subject: RE: [PATCH] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Topic: [PATCH] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Index: AQHaCxDLYKp/eAjaS0W34g/VSus9CrBta9wAgABBWcA=
Date:   Mon, 6 Nov 2023 19:06:03 +0000
Message-ID: <BL0PR04MB6564E2DDCA36806907F600BAFCAAA@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20231030090906.1897035-1-avri.altman@wdc.com>
 <557eb489-3e1d-4cbd-b62d-d3046870a4cc@intel.com>
In-Reply-To: <557eb489-3e1d-4cbd-b62d-d3046870a4cc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|PH0PR04MB7288:EE_
x-ms-office365-filtering-correlation-id: c763933f-0c4e-4362-a813-08dbdefb6bd8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIhXIidgWXue2+RX64rF5oPSvto8OsarWEiDiWRptI1FBgWo3x8P24+WoTymq31UFbP0MjwZE2nRiF3c9NfiTruI5Io9DLW59406PFVySNrub/ypJ7Dq21sNeyEJBG/ZmqOB+68au4NWYfbiwzZ1MKDVHDXxZuKFn6gZmnKuirXmTaGsm6BDFYdWOiC0CdU+jx0aNYZ+gDNnnS6Hn1aAX1Rf7FK52WUyRsaErWowve6CzYJM/IU7fdzY8HbQ2Up2PS9MWKkfVZvgufcsrk3YuljTDg8Uvlk+PGGJMwvw8earuaUREGa+jUNP60soyOIuEPFVwNt2sUbNox5AfgHmpjRZf7y502Conf2Rh69xevHOVNhDV9GAlS7asYugvaP4i6Jdodxdw1BPbqKRlbcw2tU7MO9Zc9AVKLwQJwlcK9YPqXbFla0FACXI1pvSMhGNKBWaoukkPXGumfkam3KsDwJm/Jw/yPLvr9VleHcLi0kDeiSypZNTs6XVXbEXL0FIT0XU7s5n3UhwSoSYv2RX6yYnYnWm20UDRvTIR3t2rBDtExyKyxItFNgwovFiPFDf992ai9paMWTGnpwOa2qBLcvizpK04Ecbl7rH1YK1B8NygQNCAIehVuPXaTkiEkOA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38070700009)(33656002)(55016003)(52536014)(316002)(4326008)(8936002)(8676002)(83380400001)(26005)(66476007)(110136005)(64756008)(54906003)(66946007)(66446008)(66556008)(5660300002)(76116006)(41300700001)(478600001)(9686003)(71200400001)(7696005)(53546011)(6506007)(122000001)(2906002)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UllDQVBjWmplNnpBWTlicEZkZXJ0UXdHVFpvLzEzQWZMUktzdWc2QWVjeStm?=
 =?utf-8?B?RW9DNjRaNGRxUVlveDdWMlVPMGZ4ZEZZa01KbFlGcFJJemIzeDk0L0dxOWNn?=
 =?utf-8?B?SUxoWmFibmpNUmhHQ2FpdzZQZitVZTB3ZHNyYjArWmFzRFp0c3ZxR29EMGxK?=
 =?utf-8?B?QTd3RXFCcXh3OVZDS0N3U2ZoYzlqQ1JPOUJDNkxlMEx2bDgvS0J2cTBDcDY2?=
 =?utf-8?B?V0lIQ1hRME1WZDdzc29aWVVxTTZMQ1ZrVGJDeGYxV0JYUE1MVTcvWGdpUVhu?=
 =?utf-8?B?VVpreEp4MHJqYzZHVzNRNXNvUjF2azh1cHc3cVNRZHo5OCthTTZ0UEJLUHhC?=
 =?utf-8?B?anVLZ1dKYUtJQ0U3SWVldzNCaG9adkx3eEpuRGlIeWdaTGVWR2QyenBVNTRB?=
 =?utf-8?B?YTZPSEhnT1Fhb1NhTEVBVDQvZXNMR0VCa0JaYWdKUVlxMkltN014VlhQRE5C?=
 =?utf-8?B?aFhEYVdvamtkamw4dnlPcXJ6aW0xUHRYTHV0MlorM2J6KzBSU3ZKU1hYbWcz?=
 =?utf-8?B?N0hBdDBOWGp6NnVnaDNCV1pTRngxaDU5dlZFMHArOWhYVW11eCtRdlNISkph?=
 =?utf-8?B?ak14dTZxM3ZTZWhJdGFJWGI2VnBDZ3FoeE8xQTBsWXVQcmMyTDVHclFnMnNI?=
 =?utf-8?B?N0s1b2VsYkNZQkJxREc3VkVnSWw3bWVBMkk0MmxSYjJSNW9uTmluZ25xM04x?=
 =?utf-8?B?V0MwOWlscDhKSENnYjBNVDA3WEc3em1rZHNYaWg1cWJpWld6S2dLanFKc1k3?=
 =?utf-8?B?MUd3M1BEQWc5NUNOUFhRVGtZV2xwTS8xZmVwQS9XMWtyaVJGRXVuRmdkNU9y?=
 =?utf-8?B?ZDhpNk9nL3Z4V3NoN0wrOVloRDhWbWwyeTlYN3d5Y2ZqQzNEcUNLNm5jZFMy?=
 =?utf-8?B?OFRya1ZmMDNlSjRaUFljL2dwT2Z5YzdPSGFGM3E3dmtNYjA2dklkSXJsUzhi?=
 =?utf-8?B?MXBWeStMNDBaVmhMQ1VlMEhuZm92dmxrUTNtQXREd0hyQnVMcjVnUkM4UHpH?=
 =?utf-8?B?eE5vRFVobzczdUpDeEtmMmRDRm9venIwR3VzWnM2REVYeUcyOUpPa3JPdkxN?=
 =?utf-8?B?QzFsS3k3eEhIQncyWWNXTjJTVzNOWEFVQ2xmanExY3RTQ3dmQVI0OVNrYnhU?=
 =?utf-8?B?Mm1NT0MvSXN0WDBOSmVsb3IrWHB2U2FvSGk4b255TTVCdzR2dldrSFNJenMr?=
 =?utf-8?B?Zzl2dmlWZk5jaXpXOTdBb2xmNlJJMFRheGZBNy9qMVViKzVjL3ZYYTdkWXo3?=
 =?utf-8?B?SGEzQXJwSlZPcE5USW93K0FZTXBNcUFsbG5sNkpjK2NldHZQWDhvbWtVNlJR?=
 =?utf-8?B?YW0wT3NMZEZjVkhISEZ0MlRFMEZBd0xOS3FTdGF4YWdyZ1dLaFpMRUhCNTRo?=
 =?utf-8?B?TVZlS1htM0tadjBFcWpoQ2JEL0tnUnB3L1hHWUNBdXdtcFlHM21uRGpRMUl1?=
 =?utf-8?B?aEk1NGNaTk04eTYvaTdOOEppSGk3T2k0aHlqWnM2ZGVOVnZBZkloZmhWYTdy?=
 =?utf-8?B?U0JpYk5VSlA5SnR2cm5DeTBHU2Z2YW05VXhPVW9ybytHVHl5T1l1QWZvWFFG?=
 =?utf-8?B?RGdubm9tRk9HMmVpVXFmdWJ1OVV5Z2phbTUwb09BKzM2eHNGd1gxbjZsWUZq?=
 =?utf-8?B?SFVPcnQ3RnlVaVlzRGpkdUlnY2pKaVdQdDlrU0xIa2VFWW9IMGtHLzJCUXJ4?=
 =?utf-8?B?K1pNN1Z3SUwzd0hxbjhMeHdWdXcvZWdEbFhxWGlZTVpNY1hoeWhXOHh3aUlq?=
 =?utf-8?B?V09XR0w4T29QUFRjTHVVYVFocWYvUWp5K21ObXN5dllZbStJNUo1UWlRdnk1?=
 =?utf-8?B?TjhhcUU0UW41eUl0UGZEejM4dkRjZ2RRVzZrcWUxcGtTd0ltWDZYOTY3cDRr?=
 =?utf-8?B?eWkvcDdPYXJ1LzNZcEZqUDExd3E3VVZQenBoM1daVGJxY29ZQldnQklnWXZ6?=
 =?utf-8?B?d05FY29RUXRvZnlBaVlTLzc4QytBcW1TZnN6Y0ZFajZIYkhsem9mTlJpTDdP?=
 =?utf-8?B?ejFubmZOcTZwZkl2V2JhL1dFZ3VERElQYUdzL042V3JOME5oWTlCRG1RVjMv?=
 =?utf-8?B?czJtWnBKWlh2UEJUbzdVY1ZCRTFLTG5pWHVNYVhPTlQwZEVlTStuSitCOTUw?=
 =?utf-8?Q?QjKoaB759qpF0UrNVW3tHAuCx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2iXvf16hIefhUHRDUaxIdoYA0VpufgbfZMveg2cXq2hbe+ekb0aMM4e4BYx89JXFQ6dsJhMGTr1sh0PW2YyZFlkKdKJyfsUflP6XAbxt+yxa5e+YyUB7bBd0kj/0hXlvbrN01gdaW67r6WGk1tCluada/mHKmletKDJLTTOX1sNgAd4TERolMbn39KKhzRQMH6weX4Ys5Fs7QB+AuW3NoC9Bq3kpfcIRQc8coZMlsgPSHfCBphbB+gy/k9zl+fz2jg7jk6vmZrsfkGNcu7AUZhqdygWewio17SPRV6vg1m35b9Jfi1wl/524lOGUpPT+Yd0j5fEfrLFaNgN9VgACTvMVK2Jr8STwrAIZZ5NNa/B/0OrarCm5FQr69pOBfYuc7m7oC92oieQFpxX7zg24+BPLou+KNGdtEex5+xJdzzsvPZdHPUkiawiMB0RSafNbnesw8i35KzvG4ZXlmm8lfgTzJUutvE+04a54HsyeInCPki7F3gRvxPjTvZ1F3VdOBpJKbs/0c+YyX7bSLC/qsYXSnToNLlYa93UpqVqHtcx63OVYoWr2wvvoABuGpEtq7dpj71cRu7DJiRZGZlGCGfrKB95H66fwh9jslduQCE3Lvr8Bk3lC3+r4BhNNTv0d7ev5FKVUcSA4E5dx9iM5PIaJg2VdSFou583tCdYCt5HQP7SuCKL/eoxRWjD15Rs9IdyfUdm9SQP1MosPLMEfs/mrERwNy/6QVRrlXeYU0H0wJ6W1aJuMhBokuK9CuT5bGUhgeaG9+M7ULaPZPw1DeIXIR2WQXeWJWG2DS+ei8GGLXy+mQawWRJfwdLOpoBCeRYirIQ8BNLyFYWvYEc3IKEo4lRuC4PUk/LxVmhHBOIhPgGIEIyPqgir8OEeDC99SxdJorkuZ9qkbrZOen3MrhA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c763933f-0c4e-4362-a813-08dbdefb6bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 19:06:03.0519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qzqq+thw2ruMVEhao6VE/IxN4l+sLP9ypMY7Yn0ZP1KjbPOiWf5dJqHu0DiJecj9IoLLRKlTjkehQxV7OghUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7288
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBPbiAzMC8xMC8yMyAxMTowOSwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gRmllbGQgRmlybXdh
cmUgVXBkYXRlIChmZnUpIG1heSB1c2UgY2xvc2UtZW5kZWQgb3Igb3BlbiBlbmRlZCBzZXF1ZW5j
ZS4NCj4gPiBFYWNoIHN1Y2ggc2VxdWVuY2UgaXMgY29tcHJpc2VkIG9mIGEgd3JpdGUgY29tbWFu
ZHMgZW5jbG9zZWQgYmV0d2VlbiAyDQo+ID4gc3dpdGNoIGNvbW1hbmRzIC0gdG8gYW5kIGZyb20g
ZmZ1IG1vZGUuIFNvIGZvciB0aGUgY2xvc2UtZW5kZWQgY2FzZSwNCj4gPiBpdCB3aWxsIGJlOiBj
bWQ2LT5jbWQyMy1jbWQyNS1jbWQ2Lg0KPiA+DQo+ID4gU29tZSBob3N0IGNvbnRyb2xsZXJzIGhv
d2V2ZXIsIGdldCBjb25mdXNlZCB3aGVuIG11bHRpLWJsb2NrIHJ3IGlzDQo+ID4gc2VudCB3aXRo
b3V0IHNiYywgYW5kIG1heSBnZW5lcmF0ZSBhdXRvLWNtZDEyIHdoaWNoIGJyZWFrcyB0aGUgZmZ1
DQo+IHNlcXVlbmNlLg0KPiA+IEkgZW5jb3VudGVyZWQgIHRoaXMgaXNzdWUgd2hpbGUgdGVzdGlu
ZyBmd3VwZCAoZ2l0aHViLmNvbS9md3VwZC9md3VwZCkNCj4gPiBvbiBIUCBDaHJvbWVib29rIHgy
LCBhIHF1YWxjb21tIGJhc2VkIFFDLTdjLCBjb2RlIG5hbWUgLSBzdHJvbmdiYWQuDQo+ID4NCj4g
PiBJbnN0ZWFkIG9mIGEgcXVpcmssIG9yIGhvb2tpbmcgdGhlIHJlcXVlc3QgZnVuY3Rpb24gb2Yg
dGhlIG1zbSBvcHMsIGl0DQo+ID4gd291bGQgYmUgYmV0dGVyIHRvIGZpeCB0aGUgaW9jdGwgaGFu
ZGxpbmcgYW5kIG1ha2UgaXQgdXNlIG1ycS5zYmMNCj4gPiBpbnN0ZWFkIG9mIGlzc3VpbmcgU0VU
X0JMT0NLX0NPVU5UIHNlcGFyYXRlbHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBdnJpIEFs
dG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvY29y
ZS9ibG9jay5jIHwgNDENCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tDQo+ID4gIGluY2x1ZGUvbGludXgvbW1jL21tYy5oICB8ICAxICsNCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2su
YyBpbmRleA0KPiA+IDNhOGYyN2MzZTMxMC4uNmQ5NDYxN2VmMjA2IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxv
Y2suYw0KPiA+IEBAIC00MDAsNiArNDAwLDEwIEBAIHN0cnVjdCBtbWNfYmxrX2lvY19kYXRhIHsN
Cj4gPiAgICAgICBzdHJ1Y3QgbW1jX2lvY19jbWQgaWM7DQo+ID4gICAgICAgdW5zaWduZWQgY2hh
ciAqYnVmOw0KPiA+ICAgICAgIHU2NCBidWZfYnl0ZXM7DQo+ID4gKyAgICAgdW5zaWduZWQgaW50
IGZsYWdzOw0KPiA+ICsjZGVmaW5lIE1NQ19CTEtfSU9DX0RST1AgICAgIEJJVCgwKSAgLyogZHJv
cCB0aGlzIG1ycSAqLw0KPiA+ICsjZGVmaW5lIE1NQ19CTEtfSU9DX1NCQyAgICAgIEJJVCgxKSAg
LyogdXNlIG1ycS5zYmMgKi8NCj4gPiArDQo+ID4gICAgICAgc3RydWN0IG1tY19ycG1iX2RhdGEg
KnJwbWI7DQo+ID4gIH07DQo+ID4NCj4gPiBAQCAtNDc5LDYgKzQ4Myw5IEBAIHN0YXRpYyBpbnQg
X19tbWNfYmxrX2lvY3RsX2NtZChzdHJ1Y3QgbW1jX2NhcmQNCj4gKmNhcmQsIHN0cnVjdCBtbWNf
YmxrX2RhdGEgKm1kLA0KPiA+ICAgICAgIGlmICghY2FyZCB8fCAhbWQgfHwgIWlkYXRhKQ0KPiA+
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiArICAgICBpZiAoaWRhdGEt
PmZsYWdzICYgTU1DX0JMS19JT0NfRFJPUCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0K
PiA+ICsNCj4gPiAgICAgICAvKg0KPiA+ICAgICAgICAqIFRoZSBSUE1CIGFjY2Vzc2VzIGNvbWVz
IGluIGZyb20gdGhlIGNoYXJhY3RlciBkZXZpY2UsIHNvIHdlDQo+ID4gICAgICAgICogbmVlZCB0
byB0YXJnZXQgdGhlc2UgZXhwbGljaXRseS4gRWxzZSB3ZSBqdXN0IHRhcmdldCB0aGUgQEANCj4g
PiAtNTMyLDE0ICs1MzksMTkgQEAgc3RhdGljIGludCBfX21tY19ibGtfaW9jdGxfY21kKHN0cnVj
dCBtbWNfY2FyZA0KPiAqY2FyZCwgc3RydWN0IG1tY19ibGtfZGF0YSAqbWQsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gLSAgICAg
aWYgKGlkYXRhLT5ycG1iKSB7DQo+ID4gKyAgICAgaWYgKGlkYXRhLT5ycG1iIHx8IChpZGF0YS0+
ZmxhZ3MgJiBNTUNfQkxLX0lPQ19TQkMpKSB7DQo+ID4gKyAgICAgICAgICAgICB1MzIgc2JjX2Fy
ZyA9IGRhdGEuYmxvY2tzOw0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgIHNiYy5vcGNvZGUgPSBN
TUNfU0VUX0JMT0NLX0NPVU5UOw0KPiA+ICAgICAgICAgICAgICAgLyoNCj4gPiAgICAgICAgICAg
ICAgICAqIFdlIGRvbid0IGRvIGFueSBibG9ja2NvdW50IHZhbGlkYXRpb24gYmVjYXVzZSB0aGUg
bWF4IHNpemUNCj4gPiAgICAgICAgICAgICAgICAqIG1heSBiZSBpbmNyZWFzZWQgYnkgYSBmdXR1
cmUgc3RhbmRhcmQuIFdlIGp1c3QgY29weSB0aGUNCj4gPiAgICAgICAgICAgICAgICAqICdSZWxp
YWJsZSBXcml0ZScgYml0IGhlcmUuDQo+ID4gICAgICAgICAgICAgICAgKi8NCj4gPiAtICAgICAg
ICAgICAgIHNiYy5hcmcgPSBkYXRhLmJsb2NrcyB8IChpZGF0YS0+aWMud3JpdGVfZmxhZyAmIEJJ
VCgzMSkpOw0KPiA+ICsgICAgICAgICAgICAgaWYgKGlkYXRhLT5ycG1iKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICBzYmNfYXJnIHw9IChpZGF0YS0+aWMud3JpdGVfZmxhZyAmIEJJVCgzMSkp
Ow0KPiANCj4gV2hhdCBhYm91dCBzdXBwb3J0aW5nIG1vcmUgZ2VuZXJpYyB1c2UtY2FzZXMgd2l0
aCBvdGhlciBpbmZvcm1hdGlvbiBpbiB0aGUNCj4gYXJnIG9mIENNRDIzIGlkYXRhLCBzdWNoIGFz
IHJlbGlhYmxlIHdyaXRlIGV0Yz8gIFBlcmhhcHMgbGluayB0aGUgb3RoZXIgaWRhdGENCj4gYW5k
IHBvcHVsYXRlIHNiYyBvcGNvZGUgYW5kIGFyZyBmcm9tIHRoYXQuDQpBY3R1YWxseSBmZnUgc2Vx
dWVuY2UgY29tZXMgYXMgYSBjbG9zZSwgd2VsbC1kZWZpbmVkIGZvcm0uIA0KRXhjZXB0IGZmdSAm
IHJwbWIsIEkgYW0gdW4tYXdhcmUgb2YgYW55IG90aGVyIHVzZS1jYXNlIHRoYXQgYXBwbHkgaGVy
ZS4NClRodXMsIEkgd2lzaCB0byBtYWtlIGl0IGFueXRoaW5nIGJ1dCBnZW5lcmljIC0gYXMgc3Bl
Y2lmaWMgYXMgcG9zc2libGUgZm9yIGNsb3NlLWVuZGVkIGZmdS4NCg0KU2F5aW5nIHRoYXQsIEkg
Y2FtZSB0byByZWFsaXplIHRoYXQgZmZ1IGRvZXNuJ3QgdXNlIHJlbGlhYmxlIHdyaXRlIChzdHJh
bmdlLCBpc24ndCBpdD8pLA0KU28gc2JjLmFyZyA9IGRhdGEuYmxvY2tzIHwgKGlkYXRhLT5pYy53
cml0ZV9mbGFnICYgQklUKDMxKSkgY2FuIHN0YXkgYXMgaXQgaXMuDQpXaWxsIGZpeCB0aGlzIGlu
IHYyLg0KDQo+IA0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIHNiYy5hcmcgPSBzYmNfYXJnOw0K
PiA+ICAgICAgICAgICAgICAgc2JjLmZsYWdzID0gTU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7DQo+
ID4gICAgICAgICAgICAgICBtcnEuc2JjID0gJnNiYzsNCj4gDQo+IEFsc28gY291bGQgY29weSB0
aGUgc2JjIHJlc3BvbnNlIGJhY2sgdG8gdGhlICJDTUQyMyIgaWRhdGEgYWZ0ZXINCj4gbW1jX3dh
aXRfZm9yX3JlcSgpLg0KPiANCj4gPiAgICAgICB9DQo+ID4gQEAgLTEwMzIsNiArMTA0NCwyOCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgbW1jX2Jsa19yZXNldF9zdWNjZXNzKHN0cnVjdA0KPiBtbWNf
YmxrX2RhdGEgKm1kLCBpbnQgdHlwZSkNCj4gPiAgICAgICBtZC0+cmVzZXRfZG9uZSAmPSB+dHlw
ZTsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8qIGNsb3NlLWVuZGVkIGZmdSAqLw0KPiA+ICtzdGF0aWMg
dm9pZCBtbWNfYmxrX2NoZWNrX2NlX2ZmdShzdHJ1Y3QgbW1jX3F1ZXVlX3JlcSAqbXFfcnEpIHsN
Cj4gPiArICAgICBzdHJ1Y3QgbW1jX2Jsa19pb2NfZGF0YSAqKmlkYXRhID0gbXFfcnEtPmRydl9v
cF9kYXRhOw0KPiA+ICsNCj4gPiArICAgICBpZiAobXFfcnEtPmlvY19jb3VudCAhPSA0KQ0KPiA+
ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiArICAgICBpZiAoaWRhdGFbMF0tPmlj
Lm9wY29kZSAhPSBNTUNfU1dJVENIKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsN
Cj4gPiArICAgICBpZiAoTU1DX0VYVFJBQ1RfSU5ERVhfRlJPTV9BUkcoaWRhdGFbMF0tPmljLmFy
ZykgIT0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgRVhUX0NTRF9NT0RFX0NPTkZJRykNCj4g
PiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGlkYXRhWzFdLT5p
Yy5vcGNvZGUgPT0gTU1DX1NFVF9CTE9DS19DT1VOVCAmJg0KPiA+ICsgICAgICAgICBpZGF0YVsy
XS0+aWMub3Bjb2RlID09IE1NQ19XUklURV9NVUxUSVBMRV9CTE9DSykgew0KPiA+ICsgICAgICAg
ICAgICAgaWRhdGFbMV0tPmZsYWdzIHw9IE1NQ19CTEtfSU9DX0RST1A7DQo+ID4gKyAgICAgICAg
ICAgICBpZGF0YVsyXS0+ZmxhZ3MgfD0gTU1DX0JMS19JT0NfU0JDOw0KPiA+ICsgICAgIH0NCj4g
DQo+IENvdWxkIHRoaXMgYmUgbW9yZSBnZW5lcmljIGUuZy4gc2ltcGx5DQo+IA0KPiAgICAgICAg
IGZvciAoaSA9IDE7IGkgPCBtcV9ycS0+aW9jX2NvdW50OyBpKyspDQo+ICAgICAgICAgICAgICAg
ICBpZiAoaWRhdGFbaSAtIDFdLT5pYy5vcGNvZGUgPT0gTU1DX1NFVF9CTE9DS19DT1VOVCAmJg0K
PiAgICAgICAgICAgICAgICAgICAgIG1tY19vcF9tdWx0aShpZGF0YVtpICsgMV0tPmljLm9wY29k
ZSkpIHsNCkkgZ3Vlc3MgeW91IG1lYW50IChpZGF0YVtpXQ0KDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGlkYXRhW2kgLSAxXS0+ZmxhZ3MgfD0gTU1DX0JMS19JT0NfRFJPUDsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgaWRhdGFbaV0tPmZsYWdzIHw9IE1NQ19CTEtfSU9DX1NCQzsNCj4g
ICAgICAgICAgICAgICAgIH0NCj4gDQo+IHdpdGggbm8gbmVlZCB0byBjaGVjayBmb3IgNCBjbWRz
LCBNTUNfU1dJVENIIG9yDQo+IEVYVF9DU0RfTU9ERV9DT05GSUcNCkRpdHRvDQoNClRoYW5rcywN
CkF2cmkNCj4gDQo+ID4gK30NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIFRoZSBub24tYmxvY2sg
Y29tbWFuZHMgY29tZSBiYWNrIGZyb20gdGhlIGJsb2NrIGxheWVyIGFmdGVyIGl0DQo+IHF1ZXVl
ZCBpdCBhbmQNCj4gPiAgICogcHJvY2Vzc2VkIGl0IHdpdGggYWxsIG90aGVyIHJlcXVlc3RzIGFu
ZCB0aGVuIHRoZXkgZ2V0IGlzc3VlZCBpbg0KPiA+IHRoaXMgQEAgLTEwNTksNiArMTA5Myw5IEBA
IHN0YXRpYyB2b2lkIG1tY19ibGtfaXNzdWVfZHJ2X29wKHN0cnVjdA0KPiBtbWNfcXVldWUgKm1x
LCBzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0
KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIG1tY19ibGtfY2hlY2tfY2VfZmZ1KG1x
X3JxKTsNCj4gPiArDQo+ID4gICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsNCj4gPiAgICAgICBj
YXNlIE1NQ19EUlZfT1BfSU9DVExfUlBNQjoNCj4gPiAgICAgICAgICAgICAgIGlkYXRhID0gbXFf
cnEtPmRydl9vcF9kYXRhOyBkaWZmIC0tZ2l0DQo+ID4gYS9pbmNsdWRlL2xpbnV4L21tYy9tbWMu
aCBiL2luY2x1ZGUvbGludXgvbW1jL21tYy5oIGluZGV4DQo+ID4gNmY3OTkzODAzZWU3Li5kNGQx
MGNhYmFhNTcgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvbW1jLmgNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L21tYy9tbWMuaA0KPiA+IEBAIC0yNTQsNiArMjU0LDcgQEAgc3Rh
dGljIGlubGluZSBib29sIG1tY19yZWFkeV9mb3JfZGF0YSh1MzIgc3RhdHVzKQ0KPiA+ICAgKi8N
Cj4gPg0KPiA+ICAjZGVmaW5lIEVYVF9DU0RfQ01EUV9NT0RFX0VOICAgICAgICAgMTUgICAgICAv
KiBSL1cgKi8NCj4gPiArI2RlZmluZSBFWFRfQ1NEX01PREVfQ09ORklHICAgICAgICAgIDMwICAg
ICAgLyogUi9XICovDQo+ID4gICNkZWZpbmUgRVhUX0NTRF9GTFVTSF9DQUNIRSAgICAgICAgICAz
MiAgICAgIC8qIFcgKi8NCj4gPiAgI2RlZmluZSBFWFRfQ1NEX0NBQ0hFX0NUUkwgICAgICAgICAg
IDMzICAgICAgLyogUi9XICovDQo+ID4gICNkZWZpbmUgRVhUX0NTRF9QT1dFUl9PRkZfTk9USUZJ
Q0FUSU9OICAgICAgIDM0ICAgICAgLyogUi9XICovDQoNCg==
