Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11265329E1
	for <lists+linux-mmc@lfdr.de>; Tue, 24 May 2022 14:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiEXL6u (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 May 2022 07:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbiEXL6r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2022 07:58:47 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B27F62CFC;
        Tue, 24 May 2022 04:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1653393526; x=1653998326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A63kkb4mHBXEUkg2Hz+WsF55FpAjAmI5AzyFDL88SCs=;
  b=K33AV3ZcRGMomveA40z4LxADPWt6ZUEuq81ymiJtVQmPhc1TZ3jLcbSf
   ky++HBF8xBE1X0ECFywOy2ZoxcmBtLLGXEjrpzgxpbQXL6PxxQNzXKYvV
   aR1w9+FG9rdnUthvl7B87A/QTAqVceKxorh52LPAgCVS47qJZCcfZhUZ3
   Q=;
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGp/jkTCUxM7YsgPVCLDzSjTmq4DEe3pw3DFG0h95lnqc+vF27pThrJj2ikFHB3p+B8hh+rgSPa4OVC/TUkLL1V+HC3Dn4b0uUqXNAD0nyBAhTSi46oktOWH2k5j9I/Sd/+wUV74ZDOKxoZcKSMNZA14P5u79Ti9U8//wqywS7eV56UiZS9IYUfBwCNNvyrhH2Yjp+KfHyqiWYW2jAfihk3VkPRLKSDGrlYZlHsPKP8KUcnqtucErl9fYbsmD/qXQlw3nZRlExviBylXoxJZgHw7+8fVWmhWFFfhlN8V9j/J47XBSHkPL3YIcQV7WBWynmYblJdhSj67OCE3RHft+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A63kkb4mHBXEUkg2Hz+WsF55FpAjAmI5AzyFDL88SCs=;
 b=PKz3rt/itaQMrp5Stke0bIC5twxxzMZcJXWG/BqRy643x0cYChmLxXonOv8962wl5bCUZ03mr+y887NRXS748j2jypXMaENLBrPVkc4H0s8lwbUTx6MlmUs2yiIVaI7p8J9T5tRoZLENKamMeXLhJC7YxMAMaPUCOpJN06E0gqInUaxExwd+YlMpSag3YgbNs/1+fZq5eyBir1Qf6TdTrbvjW9hMtvSUboZs1o10SQn9FhbNI41VH8DAkwJ55KkR+8iwaKBhij6nUykLWme8NbEuuG4TY8++vZi+Gup91BIMSwryIl+DWixCQ4pdvwf5lb05RUVarpeREgWG4QsG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from MWHPR0201MB3466.namprd02.prod.outlook.com
 (2603:10b6:301:7b::26) by SN6PR02MB5247.namprd02.prod.outlook.com
 (2603:10b6:805:72::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 11:58:41 +0000
Received: from MWHPR0201MB3466.namprd02.prod.outlook.com
 ([fe80::9cea:75bd:9c0c:2865]) by MWHPR0201MB3466.namprd02.prod.outlook.com
 ([fe80::9cea:75bd:9c0c:2865%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 11:58:41 +0000
From:   "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>
To:     'Ulf Hansson' <ulf.hansson@linaro.org>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
CC:     "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "merez@codeaurora.org" <merez@codeaurora.org>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "huijin.park@samsung.com" <huijin.park@samsung.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        "'quic_spathi@quicinc.com'" <quic_spathi@quicinc.com>
Subject: RE: [PATCH V1] mmc: core: Add partial initialization support
Thread-Topic: [PATCH V1] mmc: core: Add partial initialization support
Thread-Index: AQHYWUysw4JXdAIBxE6DS6R+4YVYR60DYDiAgCq4Z1E=
Date:   Tue, 24 May 2022 11:58:41 +0000
Message-ID: <MWHPR0201MB3466C629ECABC8FD6B009276E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
 <CAPDyKFo7H=fOiX49gttrKO3gwe=ddYMjdgrO_xSnnZjZh7P7ZA@mail.gmail.com>
In-Reply-To: <CAPDyKFo7H=fOiX49gttrKO3gwe=ddYMjdgrO_xSnnZjZh7P7ZA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa7e2dec-eaa2-4a35-9acf-08da3d7cbef0
x-ms-traffictypediagnostic: SN6PR02MB5247:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB52474F0AB577070C00FA3BD59FD79@SN6PR02MB5247.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8aPKv0auNmkvPVEG6GY0q0PqIPixIh40Sax1f1+n4z8r7mZX9vudi3AsmSr1pCqCGC0CucfjtDiwulKli+Eut0Sh9gg+uaYQRO8JY5c8pNY2qA4lGQ73GpLouVZCK3lga8lpKgUsKiOfFxvLsebSjkIkuFrHJ2hP9E8c/AA8kc8x7/5NqWNRu0QG9hKOWtDEtkgQTSbfiFjMiHj1oiftsEZGo1PveNtCwDMpDO61V7uKI2ZNgHBYyRtT0xIR8qqV/5zzqTW02ldBAzYOlP5zWBooH8hzeueV1Ck8SAlMR6pA2NuZNy0zdkrs3ptI8jrTsRveDLszI2DCKMlPxDty1L0yGrnJiMNgt4/DERXYUy6TUpVlSEoPXhCaxg/RNie1waJlr0ZLruFr4WxdqpMqOEyh+6+WTQexywuB/hmhw0Yknp7JThMIjseld9Y3VQbuCkziRHfv5ZDq5R7fiXB2O6EZpImCB86obaNdB8bHlsuoLr2Leal7KKms1Tggq3mUBzsVSx4sLC94jxtFg5Uz95cTT2R243IfVZYS8GS233waxTQH/10W+rEFIWVVm9b3h15C6z2N9afV2MUEOw8MZ3pdC6e1HWuGVcZkjMf7ljM4rAf86WAXawslbwdTzElz9noeVK8L1mLPTJ+UnA1v4A2k2Ac8e1N/QXVxYL4R9FqgFm8zPmF685tDNssHr+1sf6/Q+aH70hgktaK+zM0ggKW5riM6zMOWz48KLnIOa4PoIxNJzvcZpMeYgzxGayjelWrhoM78e2yY2CgldNmZ2BiERI3L7Pe877LBh/gTNdc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0201MB3466.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(52536014)(55016003)(508600001)(9686003)(5660300002)(38100700002)(4326008)(66446008)(66946007)(6506007)(6636002)(76116006)(7696005)(33656002)(66556008)(54906003)(8936002)(71200400001)(64756008)(2906002)(8676002)(66476007)(107886003)(186003)(38070700005)(26005)(316002)(83380400001)(122000001)(966005)(53546011)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elpwNDRraitkTCsyNDdSVUdVY29uWG84NmhJR05pNlQwRTRyL29EYVAvOEVx?=
 =?utf-8?B?a05LNEJ4R1lYeTQ0blBnemoxTWZXUVozK2ZxM1UxaVQwVHpFemhNdTJ2Q0JE?=
 =?utf-8?B?ZnMyRGxFSEcrMXNNY0xoWDNiWE45NE9LbHRtTDVUN2d6Y2JSN29QdHN5aC9W?=
 =?utf-8?B?WXY2SVZyZm9hMFNobnMwZkNEcW1CRzlVOEpFSEV2MmI3aHExT0VKWUkrT09y?=
 =?utf-8?B?R3F2TnVQUEJhVWRyc2FubUdpdjJaWXNoWCtlN0I0N2FRdHJjV3I4NW50WWUz?=
 =?utf-8?B?TzhSK3dWVS9UamdXVWowUUhYWlMrYjlrZHBPdmlha1dBMkcwN1hBVGVnMFpX?=
 =?utf-8?B?NXN2OEdsUTBnVjgxclRxWlBvbk9YQzFnYmRvZjRBTDZzSUF0NjJwV1c5UDBR?=
 =?utf-8?B?KzFYazI5d0tSd1V2UmZjZHB4Zld3cnZtWDEveTBFZEx6dHhvaGlzeW5QZHZa?=
 =?utf-8?B?em82UDExTi9CK1pFNGVrQktVU2YxRUdrb3pBdU5ZUGtSUTBpQURpQ0pxSTR1?=
 =?utf-8?B?QjNEdnlmcFZnOGIwVnYrYzMyTFM4OFdZM1pnbEdEV21zZkh5Q1lZcExFOG01?=
 =?utf-8?B?emtEVXpxblBlN1l0QkpwM2NHbkJxV3cxdjU3UW5CZktPdmZHYllwNlhUbFZU?=
 =?utf-8?B?K0EzQTVwVVRKVHltZVFJb3I0N0UzRm9XaUhLQnA0cEVHcm5sZGs5OG9BTW1m?=
 =?utf-8?B?QldtR3NqRTcvRzMrS3hETUFXMms2QnJ3Z1pBVTNNQkV4b2RTaGxzVy9KdGdn?=
 =?utf-8?B?YVBhdjdTd0NQbWxUeWhrNFRXN04xWWJRcVZ5dVJHdUpYVFlUMVdaMldNdHVh?=
 =?utf-8?B?NFZzK1JwcGJnNjJhanh3T1hoc0tHbTVvLy95MXl5TmRJVlI4djB1VHJTeWow?=
 =?utf-8?B?MG1FWi8veGY4cGszRDlaZjJJOUx4Z0pyN3BLSWFzZHhuOFZGaXpwWHVVdE51?=
 =?utf-8?B?dUk3VnpQK2xsaVVxWkNZbXdabU9NZ2J3Rm9JV245OWs4N0d3dlVZekdLLy91?=
 =?utf-8?B?bXpFOEpYOCtsQ2ZDNFVjMm9vWk50blowQkF3SitFdjJnbGw0RnBsUDZNdjYz?=
 =?utf-8?B?azByYmhKemtabW1ZbXljbHdUck5sTEhucmV4NzNZSkoreWVHUTdRcnVzSVd1?=
 =?utf-8?B?QkhLT0VJZzRhS2FPdWVPTnBoSWJkTnM2aDBlYTVnYlpZNXRyaWdneThKNjJV?=
 =?utf-8?B?NzIvNTV2UUxOcEZRUTFtY0htbThJc01ITjZ2VXhtU2hocllORmZwUmdzVW9i?=
 =?utf-8?B?Nk1PSkFTT3VNK1VrSWp3QTdTY3N1cUFJMXlmU1RteFN2cENFNkU2elBLc3lw?=
 =?utf-8?B?azFpVGJFTERIZ1ZEcmtFaVNnaU12S05TSjcweWNJOHA2U1h3VENLT2JzWUdt?=
 =?utf-8?B?Y09hZUhubkdWK2ZGOFozY1lKVHlVeVZEaThVSktyOEhGMy9RSFZXVXl1aVk4?=
 =?utf-8?B?UFlOOHlXR3g5OTdqNUFyaXZoTit4WVlhYTlWVzZUcHFNLzBJOVNGNjRvdVBp?=
 =?utf-8?B?V1p1eEJvdlpySlBpbUNuaC9PK1lqTHpqWENSTnFMSFAwdjhodUFtRlRRNWtq?=
 =?utf-8?B?VEtzUjUzV2JNMlhUeDNHWFlSQWZvV3JDQUJDcDZOaytIdzBOUHRRdlNhdU0z?=
 =?utf-8?B?cHpITHVubTFEcXhVTHIrM0lmY29abWt3V21PWEVSeFo5Y0xjLzdKNTdXUG5t?=
 =?utf-8?B?OUJiK0NpaE9kWUxabFd1N0owZ3YzNFN1Qzd2c3F6a1FGL2NYdmMwLzJGRmgv?=
 =?utf-8?B?UkJKRXhVNFh6cS9Bd1hHN0dIbFhrU1ZWQ0g2TlY1d3pSbkhGNm15bjZuNG94?=
 =?utf-8?B?ZklBekpKcXhpNHU1em51bHpoQnVZb2k0MkFTSzVMNXdaNEZpOG9aVlIwN0Nl?=
 =?utf-8?B?Qkg0T1YzdFZjcnJ4aEFsV0NlZjN3NHhVTURtSFdTUmpabzZWNm5rOHRwaVFp?=
 =?utf-8?B?WjhoNTMyaVlDc0ZPb1JUckdDRU9sMXVCbWoxZFlWTlBwbU9TakcwV0ZTRFh3?=
 =?utf-8?B?MVhEZHd5U3c0cmtGeHZha3ZXNTZ2RXRuQU9kVHJKT1dYVWxxTGdROUJaQzVj?=
 =?utf-8?B?Wmp4VFBSUVl0ZFZVNVVyQlhTSDNxeG5VUUlOcW92d040bk9FRUs3MXRpeWxQ?=
 =?utf-8?B?ZGI3RHN2WHcyOHkxWlpTZzJXS0hNTlovTXBzbkN5M1NncmVKUU5aY053RTYr?=
 =?utf-8?B?U3hYazJyZi9GRWxEVkExa2hoRkN6cEJ4K29nSmNCR2JXcldIaW5ieitGWWJ2?=
 =?utf-8?B?QVlYSFpPb0VKNHVtZUdkMnFWK2kyQUNMN25udHVuK24wOC9aY2t6anNjMWZH?=
 =?utf-8?B?K3NuNHorRmR3Yy9mUGpDY21Ub3ptakhkVzJMbWNZeEh1V3dLbG1jUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0201MB3466.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7e2dec-eaa2-4a35-9acf-08da3d7cbef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 11:58:41.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4u6X5jChoHg37eX4uhmJAFrq8rc/EtBsvHsKi6rFVGWoKpF7LhV/LYj98NfkRBY1Zrtuk122+FaV2oFUpUGWsynRO4RSvpQutEMTqnYF1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5247
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQoNClRoZXNlIHBhdGNoZXMgd2lsbCBiZSBmdXJ0aGVyIHRha2VuIGJ5IFNhcnRoYWsuDQoN
ClRoYW5rcywNClNhdHlhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBVbGYg
SGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4gDQpTZW50OiBXZWRuZXNkYXksIEFwcmls
IDI3LCAyMDIyIDE6MDYgUE0NClRvOiBxdWljX3NwYXRoaSA8cXVpY19zcGF0aGlAcXVpY2luYy5j
b20+DQpDYzogYXZyaS5hbHRtYW5Ad2RjLmNvbTsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnOyBz
aGF3bi5saW5Acm9jay1jaGlwcy5jb207IG1lcmV6QGNvZGVhdXJvcmEub3JnOyBzLnNodHlseW92
QG9tcC5ydTsgaHVpamluLnBhcmtAc2Ftc3VuZy5jb207IGJyaWFubm9ycmlzQGNocm9taXVtLm9y
ZzsgZGlnZXR4QGdtYWlsLmNvbTsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgVmVlcmFiaGFkcmFyYW8gQmFkaWdhbnRpIDx2YmFkaWdhbkBj
b2RlYXVyb3JhLm9yZz47IFNoYWlrIFNhamlkYSBCaGFudSA8c2JoYW51QGNvZGVhdXJvcmEub3Jn
PjsgS2FtYXNhbGkgU2F0eWFuYXJheWFuIChDb25zdWx0YW50KSAoUVVJQykgPHF1aWNfa2FtYXNh
bGlAcXVpY2luYy5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIFYxXSBtbWM6IGNvcmU6IEFkZCBw
YXJ0aWFsIGluaXRpYWxpemF0aW9uIHN1cHBvcnQNCg0KT24gVHVlLCAyNiBBcHIgMjAyMiBhdCAx
MTowNCwgU3Jpbml2YXNhcmFvIFBhdGhpcGF0aSA8cXVpY19zcGF0aGlAcXVpY2luYy5jb20+IHdy
b3RlOg0KPg0KPiBGcm9tOiBNYXlhIEVyZXogPG1lcmV6QGNvZGVhdXJvcmEub3JnPg0KPg0KPiBU
aGlzIGNoYW5nZSBhZGRzIHRoZSBhYmlsaXR5IHRvIHBhcnRpYWxseSBpbml0aWFsaXplIHRoZSBN
TUMgY2FyZCBieSANCj4gdXNpbmcgY2FyZCBTbGVlcC9Bd2FrZSBzZXF1ZW5jZSAoQ01ENSkuDQo+
IENhcmQgd2lsbCBiZSBzZW50IHRvIFNsZWVwIHN0YXRlIGR1cmluZyBydW50aW1lL3N5c3RlbSBz
dXNwZW5kIGFuZCANCj4gd2lsbCBiZSB3b2tlbiB1cCBkdXJpbmcgcnVudGltZS9zeXN0ZW0gcmVz
dW1lLg0KPiBCeSB1c2luZyB0aGlzIHNlcXVlbmNlIHRoZSBjYXJkIGRvZXNuJ3QgbmVlZCBmdWxs
IGluaXRpYWxpemF0aW9uIHdoaWNoIA0KPiBnaXZlcyB0aW1lIHJlZHVjdGlvbiBpbiBzeXN0ZW0v
cnVudGltZSByZXN1bWUgcGF0aC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWF5YSBFcmV6IDxtZXJl
ekBjb2RlYXVyb3JhLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogVmVlcmFiaGFkcmFyYW8gQmFkaWdh
bnRpIDx2YmFkaWdhbkBjb2RlYXVyb3JhLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogU2hhaWsgU2Fq
aWRhIEJoYW51IDxzYmhhbnVAY29kZWF1cm9yYS5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IGthbWFz
YWxpIDxxdWljX2thbWFzYWxpQHF1aWNpbmMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZh
c2FyYW8gUGF0aGlwYXRpIDxxdWljX3NwYXRoaUBxdWljaW5jLmNvbT4NCg0KSXQgc2VlbXMgbGlr
ZSB0aGlzIHBhdGNoIGhhcyBiZWVuIHBvc3RlZCBiZWZvcmUgWzFdLiBMZXQgbWUgcmVwZWF0IG15
IHF1ZXN0aW9uIHNlbnQgYmFjayB0aGVuLg0KDQpJdCB3b3VsZCBiZSBuaWNlIGlmIHlvdSBjb3Vs
ZCBwcm92aWRlIHNvbWUgbW9yZSBleGFjdCBudW1iZXJzIG9mIHdoYXQgdGhlIGdhaW4gaXMgZm9y
IGEgY291cGxlIG9mIGRpZmZlcmVudCBlTU1DcywgdG8ganVzdGlmeSB0aGUgY2hhbmdlLg0KQ2Fu
IHlvdSBwbGVhc2UgZG8gdGhhdD8NCg0KS2luZCByZWdhcmRzDQpVZmZlDQoNClsxXQ0KaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1tYy9wYXRjaC8xNTkxMjc3Mzgx
LTc3MzQtMS1naXQtc2VuZC1lbWFpbC12YmFkaWdhbkBjb2RlYXVyb3JhLm9yZy8NCg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMgICB8IDE0OSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIHwg
ICA0ICsrDQo+ICBpbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggfCAgIDIgKw0KPiAgMyBmaWxlcyBj
aGFuZ2VkLCAxNDYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGluZGV4
IA0KPiA5YWI5MTViLi44NjkxYzAwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL21t
Yy5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gQEAgLTE5NDIsNyArMTk0Miwx
NCBAQCBzdGF0aWMgaW50IG1tY19zbGVlcF9idXN5X2NiKHZvaWQgKmNiX2RhdGEsIGJvb2wgKmJ1
c3kpDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+IC1zdGF0aWMgaW50IG1tY19zbGVl
cChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+ICtzdGF0aWMgaW50IG1tY19jYW5fc2xlZXBhd2Fr
ZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpIHsNCj4gKyAgICAgICByZXR1cm4gaG9zdCAmJiAoaG9z
dC0+Y2FwczIgJiBNTUNfQ0FQMl9TTEVFUF9BV0FLRSkgJiYgaG9zdC0+Y2FyZCAmJg0KPiArICAg
ICAgICAgICAgICAgKGhvc3QtPmNhcmQtPmV4dF9jc2QucmV2ID49IDMpOw0KPiArDQo+ICt9DQo+
ICsNCj4gK3N0YXRpYyBpbnQgbW1jX3NsZWVwYXdha2Uoc3RydWN0IG1tY19ob3N0ICpob3N0LCBi
b29sIHNsZWVwKQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBtbWNfY29tbWFuZCBjbWQgPSB7fTsN
Cj4gICAgICAgICBzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQgPSBob3N0LT5jYXJkOyBAQCAtMTk1Mywx
NCArMTk2MCwxNyBAQCANCj4gc3RhdGljIGludCBtbWNfc2xlZXAoc3RydWN0IG1tY19ob3N0ICpo
b3N0KQ0KPiAgICAgICAgIC8qIFJlLXR1bmluZyBjYW4ndCBiZSBkb25lIG9uY2UgdGhlIGNhcmQg
aXMgZGVzZWxlY3RlZCAqLw0KPiAgICAgICAgIG1tY19yZXR1bmVfaG9sZChob3N0KTsNCj4NCj4g
LSAgICAgICBlcnIgPSBtbWNfZGVzZWxlY3RfY2FyZHMoaG9zdCk7DQo+IC0gICAgICAgaWYgKGVy
cikNCj4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0X3JlbGVhc2U7DQo+ICsgICAgICAgaWYgKHNs
ZWVwKSB7DQo+ICsgICAgICAgICAgICAgICBlcnIgPSBtbWNfZGVzZWxlY3RfY2FyZHMoaG9zdCk7
DQo+ICsgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIG91dF9yZWxlYXNlOw0KPiArICAgICAgIH0NCj4NCj4gICAgICAgICBjbWQub3Bjb2RlID0g
TU1DX1NMRUVQX0FXQUtFOw0KPiAgICAgICAgIGNtZC5hcmcgPSBjYXJkLT5yY2EgPDwgMTY7DQo+
IC0gICAgICAgY21kLmFyZyB8PSAxIDw8IDE1Ow0KPiAgICAgICAgIHVzZV9yMWJfcmVzcCA9IG1t
Y19wcmVwYXJlX2J1c3lfY21kKGhvc3QsICZjbWQsIHRpbWVvdXRfbXMpOw0KPiArICAgICAgIGlm
IChzbGVlcCkNCj4gKyAgICAgICAgICAgICAgIGNtZC5hcmcgfD0gMSA8PCAxNTsNCj4NCj4gICAg
ICAgICBlcnIgPSBtbWNfd2FpdF9mb3JfY21kKGhvc3QsICZjbWQsIDApOw0KPiAgICAgICAgIGlm
IChlcnIpDQo+IEBAIC0xOTgyLDYgKzE5OTIsOSBAQCBzdGF0aWMgaW50IG1tY19zbGVlcChzdHJ1
Y3QgbW1jX2hvc3QgKmhvc3QpDQo+DQo+ICAgICAgICAgZXJyID0gX19tbWNfcG9sbF9mb3JfYnVz
eShob3N0LCAwLCB0aW1lb3V0X21zLCANCj4gJm1tY19zbGVlcF9idXN5X2NiLCBob3N0KTsNCj4N
Cj4gKyAgICAgICBpZiAoIXNsZWVwKQ0KPiArICAgICAgICAgICAgICAgZXJyID0gbW1jX3NlbGVj
dF9jYXJkKGNhcmQpOw0KPiArDQo+ICBvdXRfcmVsZWFzZToNCj4gICAgICAgICBtbWNfcmV0dW5l
X3JlbGVhc2UoaG9zdCk7DQo+ICAgICAgICAgcmV0dXJuIGVycjsNCj4gQEAgLTIwODAsNiArMjA5
Myw2NiBAQCBzdGF0aWMgaW50IF9tbWNfZmx1c2hfY2FjaGUoc3RydWN0IG1tY19ob3N0ICpob3N0
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoIiVzOiBjYWNoZSBmbHVzaCBlcnJv
ciAlZFxuIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1tY19ob3N0bmFtZSho
b3N0KSwgZXJyKTsNCj4gICAgICAgICB9DQo+ICsgICAgICAgcmV0dXJuIGVycjsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIGludCBtbWNfY2FjaGVfY2FyZF9leHRfY3NkKHN0cnVjdCBtbWNfaG9zdCAq
aG9zdCkgew0KPiArICAgICAgIGludCBlcnI7DQo+ICsgICAgICAgdTggKmV4dF9jc2Q7DQo+ICsg
ICAgICAgc3RydWN0IG1tY19jYXJkICpjYXJkID0gaG9zdC0+Y2FyZDsNCj4gKw0KPiArICAgICAg
IGVyciA9IG1tY19nZXRfZXh0X2NzZChjYXJkLCAmZXh0X2NzZCk7DQo+ICsgICAgICAgaWYgKGVy
ciB8fCAhZXh0X2NzZCkgew0KPiArICAgICAgICAgICAgICAgcHJfZXJyKCIlczogJXM6IG1tY19n
ZXRfZXh0X2NzZCBmYWlsZWQgKCVkKVxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgbW1j
X2hvc3RuYW1lKGhvc3QpLCBfX2Z1bmNfXywgZXJyKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVy
biBlcnI7DQo+ICsgICAgICAgfQ0KPiArICAgICAgIC8qIG9ubHkgY2FjaGUgcmVhZC93cml0ZSBm
aWVsZHMgdGhhdCB0aGUgc3cgY2hhbmdlcyAqLw0KPiArICAgICAgIGNhcmQtPmV4dF9jc2QucmF3
X2V4dF9jc2RfY21kcSA9IGV4dF9jc2RbRVhUX0NTRF9DTURRX01PREVfRU5dOw0KPiArICAgICAg
IGNhcmQtPmV4dF9jc2QucmF3X2V4dF9jc2RfY2FjaGVfY3RybCA9IGV4dF9jc2RbRVhUX0NTRF9D
QUNIRV9DVFJMXTsNCj4gKyAgICAgICBjYXJkLT5leHRfY3NkLnJhd19leHRfY3NkX2J1c193aWR0
aCA9IGV4dF9jc2RbRVhUX0NTRF9CVVNfV0lEVEhdOw0KPiArICAgICAgIGNhcmQtPmV4dF9jc2Qu
cmF3X2V4dF9jc2RfaHNfdGltaW5nID0gDQo+ICsgZXh0X2NzZFtFWFRfQ1NEX0hTX1RJTUlOR107
DQo+ICsNCj4gKyAgICAgICBrZnJlZShleHRfY3NkKTsNCj4gKw0KPiArICAgICAgIHJldHVybiAw
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG1tY190ZXN0X2F3YWtlX2V4dF9jc2Qoc3RydWN0
IG1tY19ob3N0ICpob3N0KSB7DQo+ICsgICAgICAgaW50IGVycjsNCj4gKyAgICAgICB1OCAqZXh0
X2NzZDsNCj4gKyAgICAgICBzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQgPSBob3N0LT5jYXJkOw0KPiAr
DQo+ICsgICAgICAgZXJyID0gbW1jX2dldF9leHRfY3NkKGNhcmQsICZleHRfY3NkKTsNCj4gKyAg
ICAgICBpZiAoZXJyKSB7DQo+ICsgICAgICAgICAgICAgICBwcl9lcnIoIiVzOiAlczogbW1jX2dl
dF9leHRfY3NkIGZhaWxlZCAoJWQpXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBtbWNf
aG9zdG5hbWUoaG9zdCksIF9fZnVuY19fLCBlcnIpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJu
IGVycjsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICAvKiBvbmx5IGNvbXBhcmUgcmVhZC93
cml0ZSBmaWVsZHMgdGhhdCB0aGUgc3cgY2hhbmdlcyAqLw0KPiArICAgICAgIHByX2RlYnVnKCIl
czogJXM6IHR5cGUoY2FjaGVkOmN1cnJlbnQpIGNtZHEoJWQ6JWQpIGNhY2hlX2N0cmwoJWQ6JWQp
IGJ1c193aWR0aCAoJWQ6JWQpIHRpbWluZyglZDolZClcbiIsDQo+ICsgICAgICAgICAgICAgICBt
bWNfaG9zdG5hbWUoaG9zdCksIF9fZnVuY19fLA0KPiArICAgICAgICAgICAgICAgY2FyZC0+ZXh0
X2NzZC5yYXdfZXh0X2NzZF9jbWRxLA0KPiArICAgICAgICAgICAgICAgZXh0X2NzZFtFWFRfQ1NE
X0NNRFFfTU9ERV9FTl0sDQo+ICsgICAgICAgICAgICAgICBjYXJkLT5leHRfY3NkLnJhd19leHRf
Y3NkX2NhY2hlX2N0cmwsDQo+ICsgICAgICAgICAgICAgICBleHRfY3NkW0VYVF9DU0RfQ0FDSEVf
Q1RSTF0sDQo+ICsgICAgICAgICAgICAgICBjYXJkLT5leHRfY3NkLnJhd19leHRfY3NkX2J1c193
aWR0aCwNCj4gKyAgICAgICAgICAgICAgIGV4dF9jc2RbRVhUX0NTRF9CVVNfV0lEVEhdLA0KPiAr
ICAgICAgICAgICAgICAgY2FyZC0+ZXh0X2NzZC5yYXdfZXh0X2NzZF9oc190aW1pbmcsDQo+ICsg
ICAgICAgICAgICAgICBleHRfY3NkW0VYVF9DU0RfSFNfVElNSU5HXSk7DQo+ICsgICAgICAgZXJy
ID0gISgoY2FyZC0+ZXh0X2NzZC5yYXdfZXh0X2NzZF9jbWRxID09DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGV4dF9jc2RbRVhUX0NTRF9DTURRX01PREVfRU5dKSAmJg0KPiArICAgICAgICAg
ICAgICAgKGNhcmQtPmV4dF9jc2QucmF3X2V4dF9jc2RfY2FjaGVfY3RybCA9PQ0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBleHRfY3NkW0VYVF9DU0RfQ0FDSEVfQ1RSTF0pICYmDQo+ICsgICAg
ICAgICAgICAgICAoY2FyZC0+ZXh0X2NzZC5yYXdfZXh0X2NzZF9idXNfd2lkdGggPT0NCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZXh0X2NzZFtFWFRfQ1NEX0JVU19XSURUSF0pICYmDQo+ICsg
ICAgICAgICAgICAgICAoY2FyZC0+ZXh0X2NzZC5yYXdfZXh0X2NzZF9oc190aW1pbmcgPT0NCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgZXh0X2NzZFtFWFRfQ1NEX0hTX1RJTUlOR10pKTsNCj4g
Kw0KPiArICAgICAgIGtmcmVlKGV4dF9jc2QpOw0KPg0KPiAgICAgICAgIHJldHVybiBlcnI7DQo+
ICB9DQo+IEBAIC0yMTAzLDggKzIxNzYsMTIgQEAgc3RhdGljIGludCBfbW1jX3N1c3BlbmQoc3Ry
dWN0IG1tY19ob3N0ICpob3N0LCBib29sIGlzX3N1c3BlbmQpDQo+ICAgICAgICAgICAgICgoaG9z
dC0+Y2FwczIgJiBNTUNfQ0FQMl9GVUxMX1BXUl9DWUNMRSkgfHwgIWlzX3N1c3BlbmQgfHwNCj4g
ICAgICAgICAgICAgIChob3N0LT5jYXBzMiAmIE1NQ19DQVAyX0ZVTExfUFdSX0NZQ0xFX0lOX1NV
U1BFTkQpKSkNCj4gICAgICAgICAgICAgICAgIGVyciA9IG1tY19wb3dlcm9mZl9ub3RpZnkoaG9z
dC0+Y2FyZCwgbm90aWZ5X3R5cGUpOw0KPiAtICAgICAgIGVsc2UgaWYgKG1tY19jYW5fc2xlZXAo
aG9zdC0+Y2FyZCkpDQo+IC0gICAgICAgICAgICAgICBlcnIgPSBtbWNfc2xlZXAoaG9zdCk7DQo+
ICsgICAgICAgaWYgKG1tY19jYW5fc2xlZXBhd2FrZShob3N0KSkgew0KPiArICAgICAgICAgICAg
ICAgbWVtY3B5KCZob3N0LT5jYWNoZWRfaW9zLCAmaG9zdC0+aW9zLCBzaXplb2YoaG9zdC0+Y2Fj
aGVkX2lvcykpOw0KPiArICAgICAgICAgICAgICAgIG1tY19jYWNoZV9jYXJkX2V4dF9jc2QoaG9z
dCk7DQo+ICsgICAgICAgfQ0KPiArICAgICAgIGlmIChtbWNfY2FuX3NsZWVwKGhvc3QtPmNhcmQp
KQ0KPiArICAgICAgICAgICAgICAgZXJyID0gbW1jX3NsZWVwYXdha2UoaG9zdCwgdHJ1ZSk7DQo+
ICAgICAgICAgZWxzZSBpZiAoIW1tY19ob3N0X2lzX3NwaShob3N0KSkNCj4gICAgICAgICAgICAg
ICAgIGVyciA9IG1tY19kZXNlbGVjdF9jYXJkcyhob3N0KTsNCj4NCj4gQEAgLTIxMTcsNiArMjE5
NCw0OCBAQCBzdGF0aWMgaW50IF9tbWNfc3VzcGVuZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIGJv
b2wgaXNfc3VzcGVuZCkNCj4gICAgICAgICByZXR1cm4gZXJyOw0KPiAgfQ0KPg0KPiArc3RhdGlj
IGludCBtbWNfcGFydGlhbF9pbml0KHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkgew0KPiArICAgICAg
IGludCBlcnIgPSAwOw0KPiArICAgICAgIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCA9IGhvc3QtPmNh
cmQ7DQo+ICsNCj4gKyAgICAgICBtbWNfc2V0X2J1c193aWR0aChob3N0LCBob3N0LT5jYWNoZWRf
aW9zLmJ1c193aWR0aCk7DQo+ICsgICAgICAgbW1jX3NldF90aW1pbmcoaG9zdCwgaG9zdC0+Y2Fj
aGVkX2lvcy50aW1pbmcpOw0KPiArICAgICAgIGlmIChob3N0LT5jYWNoZWRfaW9zLmVuaGFuY2Vk
X3N0cm9iZSkgew0KPiArICAgICAgICAgICAgICAgaG9zdC0+aW9zLmVuaGFuY2VkX3N0cm9iZSA9
IHRydWU7DQo+ICsgICAgICAgICAgICAgICBpZiAoaG9zdC0+b3BzLT5oczQwMF9lbmhhbmNlZF9z
dHJvYmUpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGhvc3QtPm9wcy0+aHM0MDBfZW5oYW5j
ZWRfc3Ryb2JlKGhvc3QsICZob3N0LT5pb3MpOw0KPiArICAgICAgIH0NCj4gKyAgICAgICBtbWNf
c2V0X2Nsb2NrKGhvc3QsIGhvc3QtPmNhY2hlZF9pb3MuY2xvY2spOw0KPiArICAgICAgIG1tY19z
ZXRfYnVzX21vZGUoaG9zdCwgaG9zdC0+Y2FjaGVkX2lvcy5idXNfbW9kZSk7DQo+ICsNCj4gKyAg
ICAgICBpZiAoIW1tY19jYXJkX2hzNDAwZXMoY2FyZCkgJiYNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgKG1tY19jYXJkX2hzMjAwKGNhcmQpIHx8IG1tY19jYXJkX2hzNDAwKGNhcmQpKSkgew0K
PiArICAgICAgICAgICAgICAgZXJyID0gbW1jX2V4ZWN1dGVfdHVuaW5nKGNhcmQpOw0KPiArICAg
ICAgICAgICAgICAgaWYgKGVycikgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIo
IiVzOiAlczogVHVuaW5nIGZhaWxlZCAoJWQpXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1tY19ob3N0bmFtZShob3N0KSwgX19mdW5jX18sIGVycik7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgICAgICAgICAgICAgfQ0KPiArICAgICAg
IH0NCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFRoZSBleHRfY3NkIGlzIHJlYWQgdG8gbWFr
ZSBzdXJlIHRoZSBjYXJkIGRpZCBub3Qgd2VudCB0aHJvdWdoDQo+ICsgICAgICAgICogUG93ZXIt
ZmFpbHVyZSBkdXJpbmcgc2xlZXAgcGVyaW9kLg0KPiArICAgICAgICAqIEEgc3Vic2V0IG9mIHRo
ZSBXL0VfUCwgVy9DX1AgcmVnaXN0ZXIgd2lsbCBiZSB0ZXN0ZWQuIEluIGNhc2UNCj4gKyAgICAg
ICAgKiB0aGVzZSByZWdpc3RlcnMgdmFsdWVzIGFyZSBkaWZmZXJlbnQgZnJvbSB0aGUgdmFsdWVz
IHRoYXQgd2VyZQ0KPiArICAgICAgICAqIGNhY2hlZCBkdXJpbmcgc3VzcGVuZCwgd2Ugd2lsbCBj
b25jbHVkZSB0aGF0IGEgUG93ZXItZmFpbHVyZSBvY2N1cnJlZA0KPiArICAgICAgICAqIGFuZCB3
aWxsIGRvIGZ1bGwgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UuDQo+ICsgICAgICAgICovDQo+ICsg
ICAgICAgZXJyID0gbW1jX3Rlc3RfYXdha2VfZXh0X2NzZChob3N0KTsNCj4gKyAgICAgICBpZiAo
ZXJyKSB7DQo+ICsgICAgICAgICAgICAgICBwcl9kZWJ1ZygiJXM6ICVzOiBmYWlsIG9uIGV4dF9j
c2QgcmVhZCAoJWQpXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBtbWNfaG9zdG5hbWUo
aG9zdCksIF9fZnVuY19fLCBlcnIpOw0KPiArICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICsg
ICAgICAgfQ0KPiArb3V0Og0KPiArICAgICAgIHJldHVybiBlcnI7DQo+ICt9DQo+ICsNCj4gIC8q
DQo+ICAgKiBTdXNwZW5kIGNhbGxiYWNrDQo+ICAgKi8NCj4gQEAgLTIxMzksNyArMjI1OCw3IEBA
IHN0YXRpYyBpbnQgbW1jX3N1c3BlbmQoc3RydWN0IG1tY19ob3N0ICpob3N0KQ0KPiAgICovDQo+
ICBzdGF0aWMgaW50IF9tbWNfcmVzdW1lKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkgIHsNCj4gLSAg
ICAgICBpbnQgZXJyID0gMDsNCj4gKyAgICAgICBpbnQgZXJyID0gLUVJTlZBTDsNCj4NCj4gICAg
ICAgICBtbWNfY2xhaW1faG9zdChob3N0KTsNCj4NCj4gQEAgLTIxNDcsNyArMjI2NiwxOSBAQCBz
dGF0aWMgaW50IF9tbWNfcmVzdW1lKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkNCj4gICAgICAgICAg
ICAgICAgIGdvdG8gb3V0Ow0KPg0KPiAgICAgICAgIG1tY19wb3dlcl91cChob3N0LCBob3N0LT5j
YXJkLT5vY3IpOw0KPiAtICAgICAgIGVyciA9IG1tY19pbml0X2NhcmQoaG9zdCwgaG9zdC0+Y2Fy
ZC0+b2NyLCBob3N0LT5jYXJkKTsNCj4gKw0KPiArICAgICAgIGlmIChtbWNfY2FuX3NsZWVwYXdh
a2UoaG9zdCkpIHsNCj4gKyAgICAgICAgICAgICAgIGVyciA9IG1tY19zbGVlcGF3YWtlKGhvc3Qs
IGZhbHNlKTsNCj4gKyAgICAgICAgICAgICAgIGlmICghZXJyKQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBlcnIgPSBtbWNfcGFydGlhbF9pbml0KGhvc3QpOw0KPiArICAgICAgICAgICAgICAg
ZWxzZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoIiVzOiAlczogYXdha2UgZmFp
bGVkICglZCksIGZhbGxiYWNrIHRvIGZ1bGwgaW5pdFxuIiwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBtbWNfaG9zdG5hbWUoaG9zdCksIF9fZnVuY19fLCBlcnIpOw0KPiArICAg
ICAgIH0NCj4gKw0KPiArICAgICAgIGlmIChlcnIpDQo+ICsgICAgICAgICAgICAgICBlcnIgPSBt
bWNfaW5pdF9jYXJkKGhvc3QsIGhvc3QtPmNhcmQtPm9jciwgaG9zdC0+Y2FyZCk7DQo+ICsNCj4g
ICAgICAgICBtbWNfY2FyZF9jbHJfc3VzcGVuZGVkKGhvc3QtPmNhcmQpOw0KPg0KPiAgb3V0Og0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIGIvaW5jbHVkZS9saW51eC9t
bWMvY2FyZC5oDQo+IGluZGV4IDM3Zjk3NTguLmVkN2Y2ZjcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgvbW1jL2NhcmQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgNCj4g
QEAgLTg2LDYgKzg2LDggQEAgc3RydWN0IG1tY19leHRfY3NkIHsNCj4gICAgICAgICB1bnNpZ25l
ZCBpbnQgICAgICAgICAgICBkYXRhX3RhZ191bml0X3NpemU7ICAgICAvKiBEQVRBIFRBRyBVTklU
IHNpemUgKi8NCj4gICAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBib290X3JvX2xvY2s7
ICAgICAgICAgICAvKiBybyBsb2NrIHN1cHBvcnQgKi8NCj4gICAgICAgICBib29sICAgICAgICAg
ICAgICAgICAgICBib290X3JvX2xvY2thYmxlOw0KPiArICAgICAgIHU4ICAgICAgICAgICAgICAg
ICAgICAgIHJhd19leHRfY3NkX2NtZHE7ICAgICAgIC8qIDE1ICovDQo+ICsgICAgICAgdTggICAg
ICAgICAgICAgICAgICAgICAgcmF3X2V4dF9jc2RfY2FjaGVfY3RybDsgLyogMzMgKi8NCj4gICAg
ICAgICBib29sICAgICAgICAgICAgICAgICAgICBmZnVfY2FwYWJsZTsgICAgLyogRmlybXdhcmUg
dXBncmFkZSBzdXBwb3J0ICovDQo+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgY21k
cV9lbjsgICAgICAgIC8qIENvbW1hbmQgUXVldWUgZW5hYmxlZCAqLw0KPiAgICAgICAgIGJvb2wg
ICAgICAgICAgICAgICAgICAgIGNtZHFfc3VwcG9ydDsgICAvKiBDb21tYW5kIFF1ZXVlIHN1cHBv
cnRlZCAqLw0KPiBAQCAtOTYsNyArOTgsOSBAQCBzdHJ1Y3QgbW1jX2V4dF9jc2Qgew0KPiAgICAg
ICAgIHU4ICAgICAgICAgICAgICAgICAgICAgIHJhd19wYXJ0aXRpb25fc3VwcG9ydDsgIC8qIDE2
MCAqLw0KPiAgICAgICAgIHU4ICAgICAgICAgICAgICAgICAgICAgIHJhd19ycG1iX3NpemVfbXVs
dDsgICAgIC8qIDE2OCAqLw0KPiAgICAgICAgIHU4ICAgICAgICAgICAgICAgICAgICAgIHJhd19l
cmFzZWRfbWVtX2NvdW50OyAgIC8qIDE4MSAqLw0KPiArICAgICAgIHU4ICAgICAgICAgICAgICAg
ICAgICAgIHJhd19leHRfY3NkX2J1c193aWR0aDsgIC8qIDE4MyAqLw0KPiAgICAgICAgIHU4ICAg
ICAgICAgICAgICAgICAgICAgIHN0cm9iZV9zdXBwb3J0OyAgICAgICAgIC8qIDE4NCAqLw0KPiAr
ICAgICAgIHU4ICAgICAgICAgICAgICAgICAgICAgIHJhd19leHRfY3NkX2hzX3RpbWluZzsgIC8q
IDE4NSAqLw0KPiAgICAgICAgIHU4ICAgICAgICAgICAgICAgICAgICAgIHJhd19leHRfY3NkX3N0
cnVjdHVyZTsgIC8qIDE5NCAqLw0KPiAgICAgICAgIHU4ICAgICAgICAgICAgICAgICAgICAgIHJh
d19jYXJkX3R5cGU7ICAgICAgICAgIC8qIDE5NiAqLw0KPiAgICAgICAgIHU4ICAgICAgICAgICAg
ICAgICAgICAgIHJhd19kcml2ZXJfc3RyZW5ndGg7ICAgIC8qIDE5NyAqLw0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIGIvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oDQo+
IGluZGV4IGMzODA3MmUuLmE5ZGRmN2EgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbW1j
L2hvc3QuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmgNCj4gQEAgLTQyMiw2ICs0
MjIsNyBAQCBzdHJ1Y3QgbW1jX2hvc3Qgew0KPiAgI2Vsc2UNCj4gICNkZWZpbmUgTU1DX0NBUDJf
Q1JZUFRPICAgICAgICAgICAgICAgIDANCj4gICNlbmRpZg0KPiArI2RlZmluZSBNTUNfQ0FQMl9T
TEVFUF9BV0FLRSAgICgxIDw8IDI5KSAgICAgICAvKiBVc2UgU2xlZXAvQXdha2UgKENNRDUpICov
DQo+ICAjZGVmaW5lIE1NQ19DQVAyX0FMVF9HUFRfVEVHUkEgKDEgPDwgMjgpICAgICAgIC8qIEhv
c3Qgd2l0aCBlTU1DIHRoYXQgaGFzIEdQVCBlbnRyeSBhdCBhIG5vbi1zdGFuZGFyZCBsb2NhdGlv
biAqLw0KPg0KPiAgICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgIGZpeGVkX2Rydl90eXBl
OyAvKiBmaXhlZCBkcml2ZXIgdHlwZSBmb3Igbm9uLXJlbW92YWJsZSBtZWRpYSAqLw0KPiBAQCAt
NDQxLDYgKzQ0Miw3IEBAIHN0cnVjdCBtbWNfaG9zdCB7DQo+ICAgICAgICAgc3BpbmxvY2tfdCAg
ICAgICAgICAgICAgbG9jazsgICAgICAgICAgIC8qIGxvY2sgZm9yIGNsYWltIGFuZCBidXMgb3Bz
ICovDQo+DQo+ICAgICAgICAgc3RydWN0IG1tY19pb3MgICAgICAgICAgaW9zOyAgICAgICAgICAg
IC8qIGN1cnJlbnQgaW8gYnVzIHNldHRpbmdzICovDQo+ICsgICAgICAgc3RydWN0IG1tY19pb3Mg
ICAgICAgICAgY2FjaGVkX2lvczsNCj4NCj4gICAgICAgICAvKiBncm91cCBiaXRmaWVsZHMgdG9n
ZXRoZXIgdG8gbWluaW1pemUgcGFkZGluZyAqLw0KPiAgICAgICAgIHVuc2lnbmVkIGludCAgICAg
ICAgICAgIHVzZV9zcGlfY3JjOjE7DQo+IC0tDQo+IDIuNy40DQo+DQo=
