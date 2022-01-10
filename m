Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2675D489BBA
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jan 2022 16:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiAJPBv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jan 2022 10:01:51 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:28235 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiAJPBu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jan 2022 10:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1641826910; x=1642431710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p4ZF5FDUBaFLZ0Crypq0k9sNh2qt+r2CgJuwegq8iJM=;
  b=dxlQLSkmZnCNvVn6kB5l0Toz5k4M+rP4dMOox9btbJZkvjbSKeRCRPKk
   htK5ptohvc1IP3jFwciw93BaSfpACYYxzTkxj51GO/8HMsAu8qSSymMse
   ZX9iaQARfIsaVftw7hMem1onRAJSv2VUedOuRl/1jQ68SVHd+Gtd9yZrp
   k=;
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlTvjgDDnZCiNkRLpR7zgjxHJQwMQnc5+vCCwFR6NsEDKr3Co9HrGqi9v4g5kUNqXju3ZxnT/rNVrKhwrqeUBPqeIuA/GAaeyNRLr94XbnuVY2aIAuJ+Rto6yRhT6lDBEF0GUY3g7jiRVm2xXmQvha1f+a1OXYTZsMC9pwzkgVyFU00dCzr7AklDy7a9K12/zu2+uDRorifV/bCvfh3PQVIj1EFsnsnJJeh4MqIWI1Pjm/aEHy3zoqTNTe7+3Pb6B6epZxarY4OFKbFyxTlR1LE99OS9Wy2vyfFnXrnuR0GA4iLEL+PaW1NybqOEGk3F2pKRBFMu/bYKESrt9ulKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4ZF5FDUBaFLZ0Crypq0k9sNh2qt+r2CgJuwegq8iJM=;
 b=jbuiwahFf/5+fsYkWWINTUsvPA/kcwefrA44yoGRCQ7LiY9cfdPeGXgmhwZwE17b68nNe8BA8EbtqugZc1L9f8i1js4ouxMBB0Emzmkjz9PFUbjrCjQCO9bnxG0GT/QEuy1K1PRB0SkigKXxh7C0Bv4paDJ+OA2xRI81j6bLkKjf/umUr850LBoDbdS3eDsHqU+0SmhtZF/V+1O6Am+7j2evG9+ca/LHQqyYGHiaJh4wC+yq8Xmlwh2h8c+OyrUu3qQKhehhV//wt5KMeZc+qXZ5KC1pA1TMJkyVdcA77MewFFwxPiAX+jnL3pxvccMGRW3mG4yZLVsZIajPmUnBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by BY5PR02MB6738.namprd02.prod.outlook.com (2603:10b6:a03:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 14:59:14 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::e4c9:c9c8:1b83:7a65]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::e4c9:c9c8:1b83:7a65%7]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 14:59:14 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "Asutosh Das (asd)" <asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "nitirawa@codeaurora.org" <nitirawa@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>
Subject: RE: [PATCH V2] mmc: debugfs: add error statistics
Thread-Topic: [PATCH V2] mmc: debugfs: add error statistics
Thread-Index: AQHX8Piwwz+Wb66W+kWR6ItlPnzKnKwzlxCAgAj8QUCAFJlQAIAB6aqQgAQ8CgCABRLj8IAABPAAgAAZJJA=
Date:   Mon, 10 Jan 2022 14:59:14 +0000
Message-ID: <SJ0PR02MB8449734EC4D16FE8FB3F8356CD509@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1639492863-7053-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <9fbec373-e667-b4a5-4b92-741f9dd2b7ee@intel.com>
 <SJ0PR02MB84499B152C13E541E19DBFB4CD7C9@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <4ba587c1-2092-285c-c13c-e3ed69fec403@intel.com>
 <SJ0PR02MB84491721325B71098AFD5E91CD4A9@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <116af24d-d508-5d3d-097c-4145b56758bc@intel.com>
 <SJ0PR02MB84490BDAA2E6E7677890F93BCD509@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <defca0bd-e43c-57c9-79b6-cf81d89c4947@intel.com>
In-Reply-To: <defca0bd-e43c-57c9-79b6-cf81d89c4947@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80311de0-1c77-46d8-35cc-08d9d449c46e
x-ms-traffictypediagnostic: BY5PR02MB6738:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB67385E18AC0A1EDACB8C00AAB1509@BY5PR02MB6738.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BsT4KNFY6ACAHQHBIl7SGZIQe3bBMm9gDu9JJdz9Ojj371sUuec8TwEuDF85DKfTjDiYX1suA89bg8Xfw6u9+6HtrMcHsLY0brD1x/X5JPYoPetqFQmo3lACDHtiChWL77uZNMu+LC+/DlWAYl+7NxekvmHE95W4/QFIY4nLM+ySrTiOdKUb7jUwxIEphNWOAX9wLgfeM9QjLS4OkPCZesTDkvk/a6tfy7z3mRvP0EddpPVzcAISfCrC+ijAtAcfBpRCbShRkVSazXIdRZd8eVo7Dmf9Q0pxErC8l9ankvYPR3wTFhkwoWdraeSc7e8w39206CY3UQjFtVhliCg507ljfnEjuVnAVvDA4GIus/HBXJAb12bO4PvRb1k1rDZTOCqPtNZ4QI4XlMCBUTMq0ZK1a8dwMJEtmYhRHfDpUY6x+99Kucqkf1u36xTjLMm3GwPzc94Db+/AdUquxGNsVLznEXKdy6acye2tsAFrluVdS6G9RYFmVCmDi0gFUbeT2QZ+/gTp09Ykkb8uSjUWbkoUzMva3sBQh4o50aeu8hghlFs2n5gZcnHSSMwoe5yJ5toq2tLjhz2wvxle7CuP3bdiy+RE+dMN3X3D71Lc5b8H6Rum8lFAUE46cY8SmgoqIAe4Th5i7PZ9N3cDTjFm2K51ANicNik5nPSPd8Ya29aom7b+opKdToSAyhJUSrr4+8+826AWrsz2QRPTEf6LkEEEbG9JaTZKljamtw1mTtg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(110136005)(54906003)(2906002)(122000001)(508600001)(38070700005)(86362001)(7416002)(8936002)(8676002)(6506007)(53546011)(316002)(66476007)(4326008)(30864003)(9686003)(5660300002)(7696005)(38100700002)(66946007)(64756008)(66556008)(66446008)(83380400001)(921005)(33656002)(55016003)(76116006)(71200400001)(186003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RS9ra3ZSamdUeVQ2Mit1dnVuOFdXZHVRZDBjREprQXlMc0YzeVhoNnZuVDFr?=
 =?utf-8?B?SytFVzFOSTB4ZExmcUVNTWFVWEVmdlFqcW51MFBlN1IxTHNLVkVvWHJjRnVn?=
 =?utf-8?B?R0hZOGpWQ2ZGYjVUeUdBQWdVZVVZbVgvUzdOMi9peVRMWU8xQzI1K0ozWDdL?=
 =?utf-8?B?STh0SE5DcVEveEdDaW1MT1pSWVpneGRhL0NPVjdkYlBsaXViMnJNY0M4OXV0?=
 =?utf-8?B?aFg1aElMak1lVS9HVGgzREZIOTVQQU00Mm5xOUpab1A4d3l2WUZtK0tLeUpS?=
 =?utf-8?B?dEJuOEdjUTJpdXFHbVBFdkorWmxRMDYxUFg4eVNUNUhaanNSR0E5OU9sV21v?=
 =?utf-8?B?QVpnTXRLaWNMaTZwclFwYVo5TDlJVzBtUDZWazR6TDc3eXhmL2Y5UWt3VlFi?=
 =?utf-8?B?dlMzemZvcmJudTJWbmlPNE4zWWpuMTFhbmdjd2UxNG9KczBSbjVUVC8vRmhj?=
 =?utf-8?B?YVhIV0ZWd1I1NmM1M3VNZEkxc0xmTm1LUFBKdUI5NHNWUStqcGdEeEpualcz?=
 =?utf-8?B?ekZqTXlhRjNVaWg1SlVqOHhQd1M0K2h1Y01MaGo2VGllZmZRWDRhMGdYdFYw?=
 =?utf-8?B?eUIvMzgyTnhndFFSajBIVGc4RTVkQ0ZjNzQxUTR4dE5UczRJK3lhNnFqdFRV?=
 =?utf-8?B?Qm1pbkx3aDdWdjEvc1RRaDNsSThiSkljOGlCbUh3Q0ZBNW8yTXQ5a1g5alFH?=
 =?utf-8?B?b2I1Z3V5azQ3Ymp1NmNZRUw2V2kyY043VlJQbGlGeXFuUXFDSWpNREZvTkg4?=
 =?utf-8?B?WG9KQ09YTk01dm5WOE1xNUI0Q21Fc2pZcTFqdEVaL2o1Um1wYkVoSndLTWlX?=
 =?utf-8?B?MERwdytTZjJvS2tMU1lpRDhTaHprbUdKUy9QY1pmWEM4bXFOZjJIQk5uQVIw?=
 =?utf-8?B?ZDhQUTVDTkc4RXNkc0ZOWkw5VnBBTFB2czVZblFPUHdOV3A3ajhPNFRmeklM?=
 =?utf-8?B?cHBiTW1FcGhZWE4yNCtoemp4bUlRMG1zaDcwT1BkYzFlQVhpYTREOVowTTNV?=
 =?utf-8?B?KytHckZxOUtITHN1eFNZWDBvY21oS3Q2WFVIY1BDMmxmWXpGUVN6R2pDcU5G?=
 =?utf-8?B?YmU4MVJsd09qMGRVRGk1MktyS1R3aE4rcGRjZXcweVN3K1hnT2NQZUY2cTRS?=
 =?utf-8?B?YkRIVmYrNCtrZUpDU0NXL1JmRU5OTmpPMzlaNTBmM1ZQWHNGcUFwVlRHb0Jr?=
 =?utf-8?B?ZWV3NVRMd24wdW5WQlBOY3ZCSWh3NHFqWU5DRHg4ZVJRUGpvTitlNUZJdy9G?=
 =?utf-8?B?RUdKTXZiSU01OTlzS0hHem1YSVdYRnNRT05aak9hWTJSdUJzdnFQSGRjcEtF?=
 =?utf-8?B?VFZEUUxPWEdSYVdhV2hvNjgxb3luL3VTZzZTdWgwRjlwZ1k4MTEvclcxRkx0?=
 =?utf-8?B?QmJESDZoeC84ZjgxZGVxVzNXRXY4cWRCRGpSODZqeVRCTTlMbUJ5SVYxL0N5?=
 =?utf-8?B?cktoRklVbzFRZkVmMnhxZWxFbDNrV21xUjc0cXp6QUR0T1ZUTUk5NnZ0VGpM?=
 =?utf-8?B?WWdxUXp2NExRbFpTOTFBT2REM2JqOU9Zam9TZ2tLbFJiOERMZnpUazZGejQ4?=
 =?utf-8?B?TTYyQnRQcmhlUTRlTzh2MjRFS3RtUDJRamgvTzl6eE8rbmFmdG8yZ3JnSE1Q?=
 =?utf-8?B?a0tsM1JtZE9xdDg5QXVacjNKNjZ0R3lBNnkycW9Rc2xucDRlTTMzY3JuRTI1?=
 =?utf-8?B?TWpzT0w3Y2MzNUc0b293RnhFdDFBb0dyZGpvdjJZS0E4Vmo4YTJaQm1wcjJR?=
 =?utf-8?B?YmVaMmw4MmNaUmRzVERQcU1IVVlTMmlmcGdsRjlMa09CR1h6VWNlZVVpYlJH?=
 =?utf-8?B?TklCVUdaQ3RYWCs1NUtMRUNwbWhmM2phdi83SHUyT3g4OVpjTmdKOFFVeTA2?=
 =?utf-8?B?OU5HSzVueVBlaEc1eWVwK2w5ZWhWNUZNTko4ZHByOEcxS0YxNGVCK01lTzJN?=
 =?utf-8?B?Tmd6aFpRZmJVTDlDbGF4ZzVJU0pIbmN0NFhRTWI1NVhWNU5ERm8wMVJ5eEl6?=
 =?utf-8?B?S1NLUEJtcE9NOHpOT2d4SEtXK0dmZ0V1aDZ2NnlGMjFpNThOb1hPQUJNWlJl?=
 =?utf-8?B?QkZUakRQU3VJalVmNmlDTmNjaGluVUJKYi9LQ1RobUlReUdJd01kd0xrZnFm?=
 =?utf-8?B?RHV4T2F1TzIrSnQyR1hWbkY1YkRTS25YaHpPRTlYSXhzK2hBc1MrREU5V0I2?=
 =?utf-8?B?d3RDdzF0eDJSRWx2RWpkb2pidXp2aDdKMHRveWtHTkJIK1lYWHdiemRyQXF5?=
 =?utf-8?B?SHZvVlRJOUF1YnVUYm5vU090Q0wxd3J4TncyRVRFa3o0STJQWDBYU0JDV3M4?=
 =?utf-8?B?L2dQeWxFTG9lak43VCs1OVJYdEdXdDRxUmpyY1dzNTFMNGp1c2hwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80311de0-1c77-46d8-35cc-08d9d449c46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 14:59:14.1488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PG8BiBZ7UrB8A9Xa2QthwPKlI2C7TBIQ9NObX7QSdB80Xrrl4umBh0dkkoWa8mBPMZV9110Fy6KxEWpvKKYCf/2ZzzQ3jDv1w3/lWOgBcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6738
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4gDQpTZW50OiBNb25kYXksIEphbnVhcnkgMTAsIDIwMjIgNjo1
OSBQTQ0KVG86IFNhamlkYSBCaGFudSAoVGVtcCkgKFFVSUMpIDxxdWljX2Nfc2JoYW51QHF1aWNp
bmMuY29tPjsgcml0ZXNoaEBjb2RlYXVyb3JhLm9yZzsgQXN1dG9zaCBEYXMgKGFzZCkgPGFzdXRv
c2hkQHF1aWNpbmMuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgYWdyb3NzQGtlcm5lbC5v
cmc7IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KQ2M6IHN0dW1tYWxhQGNvZGVhdXJvcmEub3JnOyB2YmFkaWdhbkBjb2RlYXVyb3JhLm9y
ZzsgUmFtIFByYWthc2ggR3VwdGEgKFFVSUMpIDxxdWljX3JhbXByYWthQHF1aWNpbmMuY29tPjsg
UHJhZGVlcCBQcmFnYWxsYXBhdGkgKFFVSUMpIDxxdWljX3ByYWdhbGxhQHF1aWNpbmMuY29tPjsg
c2FydGdhcmdAY29kZWF1cm9yYS5vcmc7IG5pdGlyYXdhQGNvZGVhdXJvcmEub3JnOyBzYXlhbGls
QGNvZGVhdXJvcmEub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBtbWM6IGRlYnVnZnM6IGFk
ZCBlcnJvciBzdGF0aXN0aWNzDQoNCk9uIDEwLzAxLzIwMjIgMTU6MTEsIFNhamlkYSBCaGFudSAo
VGVtcCkgKFFVSUMpIHdyb3RlOg0KPiBIaSBBZHJpYW4sDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBy
ZXZpZXcuDQo+IA0KPiBQbGVhc2UgZmluZCB0aGUgaW5saW5lIGNvbW1lbnRzDQo+IA0KPiBUaGFu
a3MsDQo+IFNhamlkYQ0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
QWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwg
SmFudWFyeSA3LCAyMDIyIDE6MTMgUE0NCj4gVG86IFNhamlkYSBCaGFudSAoVGVtcCkgKFFVSUMp
IDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPjsgDQo+IHJpdGVzaGhAY29kZWF1cm9yYS5vcmc7
IEFzdXRvc2ggRGFzIChhc2QpIDxhc3V0b3NoZEBxdWljaW5jLmNvbT47IA0KPiB1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnOyBhZ3Jvc3NAa2VybmVsLm9yZzsgYmpvcm4uYW5kZXJzc29uQGxpbmFyby5v
cmc7IA0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tbXNtQHZnZXIua2Vy
bmVsLm9yZzsgDQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHN0dW1tYWxh
QGNvZGVhdXJvcmEub3JnOyB2YmFkaWdhbkBjb2RlYXVyb3JhLm9yZzsgUmFtIFByYWthc2ggDQo+
IEd1cHRhIChRVUlDKSA8cXVpY19yYW1wcmFrYUBxdWljaW5jLmNvbT47IFByYWRlZXAgUHJhZ2Fs
bGFwYXRpIChRVUlDKSANCj4gPHF1aWNfcHJhZ2FsbGFAcXVpY2luYy5jb20+OyBzYXJ0Z2FyZ0Bj
b2RlYXVyb3JhLm9yZzsgDQo+IG5pdGlyYXdhQGNvZGVhdXJvcmEub3JnOyBzYXlhbGlsQGNvZGVh
dXJvcmEub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIG1tYzogZGVidWdmczogYWRkIGVy
cm9yIHN0YXRpc3RpY3MNCj4gDQo+IE9uIDA0LzAxLzIwMjIgMTc6MDIsIFNhamlkYSBCaGFudSAo
VGVtcCkgKFFVSUMpIHdyb3RlOg0KPj4gSGkgQWRyaWFuLA0KPj4NCj4+IFRoYW5rcyBmb3IgdGhl
IHJldmlldy4NCj4+DQo+PiBQbGVhc2UgZmluZCB0aGUgaW5saW5lIGNvbW1lbnRzLg0KPj4NCj4+
IFRoYW5rcywNCj4+IFNhamlkYQ0KPj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
PiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4+IFNlbnQ6
IE1vbmRheSwgSmFudWFyeSAzLCAyMDIyIDM6MjAgUE0NCj4+IFRvOiBTYWppZGEgQmhhbnUgKFRl
bXApIChRVUlDKSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT47IA0KPj4gcml0ZXNoaEBjb2Rl
YXVyb3JhLm9yZzsgQXN1dG9zaCBEYXMgKGFzZCkgPGFzdXRvc2hkQHF1aWNpbmMuY29tPjsgDQo+
PiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBhZ3Jvc3NAa2VybmVsLm9yZzsgDQo+PiBiam9ybi5h
bmRlcnNzb25AbGluYXJvLm9yZzsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgDQo+PiBsaW51
eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
Pj4gQ2M6IHN0dW1tYWxhQGNvZGVhdXJvcmEub3JnOyB2YmFkaWdhbkBjb2RlYXVyb3JhLm9yZzsg
UmFtIFByYWthc2ggDQo+PiBHdXB0YSAoUVVJQykgPHF1aWNfcmFtcHJha2FAcXVpY2luYy5jb20+
OyBQcmFkZWVwIFByYWdhbGxhcGF0aSAoUVVJQykgDQo+PiA8cXVpY19wcmFnYWxsYUBxdWljaW5j
LmNvbT47IHNhcnRnYXJnQGNvZGVhdXJvcmEub3JnOyANCj4+IG5pdGlyYXdhQGNvZGVhdXJvcmEu
b3JnOyBzYXlhbGlsQGNvZGVhdXJvcmEub3JnDQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBt
bWM6IGRlYnVnZnM6IGFkZCBlcnJvciBzdGF0aXN0aWNzDQo+Pg0KPj4gT24gMjEvMTIvMjAyMSAw
OToxNiwgU2FqaWRhIEJoYW51IChUZW1wKSAoUVVJQykgd3JvdGU6DQo+Pj4gSGkgQWRyaWFuLA0K
Pj4+DQo+Pj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KPj4+DQo+Pj4gUGxlYXNlIGZpbmQgdGhl
IGlubGluZSBjb21tZW50cy4NCj4+DQo+PiBJIGZpbmQgdGhlIHdheSB0aGUgaW5saW5lIGNvbW1l
bnRzIGFyZSBkb25lIGEgYml0IGRpZmZpY3VsdCB0byBmb2xsb3csIHNpbmNlIHdoYXQgSSB3cm90
ZSBpcyBub3QgcXVvdGVkLCBhbmQgd2hhdCB5b3Ugd3JvdGUgaXMgcXVvdGVkLiAgTm9ybWFsbHkg
aXQgaXMgdGhlIG90aGVyIHdheSBhcm91bmQuDQo+Pg0KPj4+DQo+Pj4gVGhhbmtzLA0KPj4+IFNh
amlkYQ0KPj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBBZHJp
YW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXks
IERlY2VtYmVyIDE1LCAyMDIxIDc6MzMgUE0NCj4+PiBUbzogU2FqaWRhIEJoYW51IChUZW1wKSAo
UVVJQykgPHF1aWNfY19zYmhhbnVAcXVpY2luYy5jb20+OyANCj4+PiByaXRlc2hoQGNvZGVhdXJv
cmEub3JnOyBBc3V0b3NoIERhcyAoYXNkKSA8YXN1dG9zaGRAcXVpY2luYy5jb20+OyANCj4+PiB1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBhZ3Jvc3NAa2VybmVsLm9yZzsgDQo+Pj4gYmpvcm4uYW5k
ZXJzc29uQGxpbmFyby5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IA0KPj4+IGxpbnV4
LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
Pj4gQ2M6IHN0dW1tYWxhQGNvZGVhdXJvcmEub3JnOyB2YmFkaWdhbkBjb2RlYXVyb3JhLm9yZzsg
UmFtIFByYWthc2ggDQo+Pj4gR3VwdGEgKFFVSUMpIDxxdWljX3JhbXByYWthQHF1aWNpbmMuY29t
PjsgUHJhZGVlcCBQcmFnYWxsYXBhdGkgDQo+Pj4gKFFVSUMpIDxxdWljX3ByYWdhbGxhQHF1aWNp
bmMuY29tPjsgc2FydGdhcmdAY29kZWF1cm9yYS5vcmc7IA0KPj4+IG5pdGlyYXdhQGNvZGVhdXJv
cmEub3JnOyBzYXlhbGlsQGNvZGVhdXJvcmEub3JnDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
Ml0gbW1jOiBkZWJ1Z2ZzOiBhZGQgZXJyb3Igc3RhdGlzdGljcw0KPj4+DQo+Pj4gT24gMTQvMTIv
MjAyMSAxNjo0MSwgU2hhaWsgU2FqaWRhIEJoYW51IHdyb3RlOg0KPj4+PiBBZGQgZGVidWdmcyBl
bnRyeSB0byBxdWVyeSBlTU1DIGFuZCBTRCBjYXJkIGVycm9ycyBzdGF0aXN0aWNzLg0KPj4+PiBU
aGlzIGZlYXR1cmUgaXMgdXNlZnVsIGZvciBkZWJ1ZyBhbmQgdGVzdGluZw0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhhbnVAcXVpY2luYy5j
b20+DQo+Pj4+IC0tLQ0KPj4+Pg0KPj4+PiBDaGFuZ2VzIHNpbmNlIFYxOg0KPj4+PiAJLVJlbW92
ZWQgc3lzZnMgZW50cnkgZm9yIGVNTUMgYW5kIFNEIGNhcmQgZXJyb3Igc3RhdGlzdGljcyBhbmQg
YWRkZWQNCj4+Pj4gCSBkZWJ1Z2ZzIGVudHJ5IGFzIHN1Z2dlc3RlZCBieSBBZHJpYW4gSHVudGVy
IGFuZCBVbGYgSGFuc3Nvbi4NCj4+Pg0KPj4+IFRoYW5rcyBmb3IgZG9pbmcgdGhpcy4NCj4+Pg0K
Pj4+PiAtLS0NCj4+Pj4gIGRyaXZlcnMvbW1jL2NvcmUvZGVidWdmcy5jIHwgMTA2ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgZHJpdmVycy9tbWMv
Y29yZS9xdWV1ZS5jICAgfCAgIDIgKw0KPj4+PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jICAg
fCAgNTMgKysrKysrKysrKysrKysrKysrLS0tLS0NCj4+Pj4gIGluY2x1ZGUvbGludXgvbW1jL2hv
c3QuaCAgIHwgIDM3ICsrKysrKysrKysrKysrKysNCj4+Pj4gIDQgZmlsZXMgY2hhbmdlZCwgMTg2
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmMgDQo+Pj4+IGIvZHJpdmVycy9tbWMvY29yZS9kZWJ1
Z2ZzLmMgaW5kZXggM2ZkYmM4MC4uNDAyMTBjMzQgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMv
bW1jL2NvcmUvZGVidWdmcy5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvZGVidWdmcy5j
DQo+Pj4+IEBAIC0yMjMsNiArMjIzLDEwNyBAQCBzdGF0aWMgaW50IG1tY19jbG9ja19vcHRfc2V0
KHZvaWQgKmRhdGEsIHU2NA0KPj4+PiB2YWwpICBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUobW1j
X2Nsb2NrX2ZvcHMsIG1tY19jbG9ja19vcHRfZ2V0LCBtbWNfY2xvY2tfb3B0X3NldCwNCj4+Pj4g
IAkiJWxsdVxuIik7DQo+Pj4+ICANCj4+Pj4gK3N0YXRpYyBpbnQgbW1jX2Vycl9zdGF0ZV9nZXQo
dm9pZCAqZGF0YSwgdTY0ICp2YWwpIHsNCj4+Pj4gKwlzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QgPSBk
YXRhOw0KPj4+PiArDQo+Pj4+ICsJaWYgKCFob3N0KQ0KPj4+PiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4+Pj4gKw0KPj4+PiArCSp2YWwgPSBob3N0LT5lcnJfc3RhdGUgPyAxIDogMDsNCj4+Pj4gKw0K
Pj4+PiArCXJldHVybiAwOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgaW50IG1tY19l
cnJfc3RhdGVfY2xlYXIodm9pZCAqZGF0YSwgdTY0IHZhbCkgew0KPj4+PiArCXN0cnVjdCBtbWNf
aG9zdCAqaG9zdCA9IGRhdGE7DQo+Pj4+ICsNCj4+Pj4gKwlpZiAoIWhvc3QpDQo+Pj4+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPj4+PiArDQo+Pj4+ICsJaG9zdC0+ZXJyX3N0YXRlID0gZmFsc2U7DQo+
Pj4NCj4+PiBJcyB0aGVyZSBtdWNoIHJlYXNvbiB0byBkaXNhYmxlIGVyciBzdGF0cyBmcm9tIHVz
ZXJzcGFjZT8NCj4+Pg0KPj4+Pj4+Pj4gWWVzICwgd2hpbGUgZGVidWdnaW5nIHdlIGNhbiBnbyBh
bmQgY2hlY2sgZXJyX3N0YXRlICwgSXQgaXMgZmFsc2UgbWVhbnMgbm8gZXJyb3JzIGhhcHBlbmVk
IGluIGRyaXZlciBsZXZlbCBhbmQgdHJ1ZSBtZWFucyBlcnJvcnMgaGFwcGVuZWQgaW4gZHJpdmVy
IGxldmVsIGFuZCB0aGVuIHdlIGNhbiBnbyBhbmQgY2hlY2sgZXJyX3N0YXRzW10gdG8ga25vdyBt
b3JlIG9uIGVycm9yIGRldGFpbHMgbGlrZSBkYXRhIENSQyAsIGNvbW1hbmQgQ1JDIGV0Yy4NCj4+
DQo+PiBUaGF0IGlzIG5vdCBleGVjdGx5IGhvdyBpdCBpcyBwcm9ncmFtbWVkLiAgImVycl9zdGF0
ZSBpcyBmYWxzZSIgbWVhbnMgbm8gZXJyb3JzIGhhdmUgYmVlbiByZWNvcmRlZCwgbm90IHRoYXQg
bm8gZXJyb3JzIGhhcHBlbmRlZC4NCj4+DQo+Pj4+Pj4+PiBJZiB1c2VyIHdhbnRzIHRvIGV4cGxp
Y2l0bHkgY2xlYXIgdGhlbiBoZSBjYW4gdXNlIHRoaXMuDQo+IA0KPiBTZWVtcyBvdmVyIGNvbXBp
bGljYXRlZC4gIEEgdXNlciBjYW4ganVzdCBkaWZmIHRoZSBvbGQgYW5kIG5ldyB2YWx1ZXM6DQo+
IA0KPiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvbW1jMC9lcnJfc3RhdHMgPiAvdG1wL29sZC1zdGF0
cyAuLi5sYXRlci4uLg0KPiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvbW1jMC9lcnJfc3RhdHMgPiAv
dG1wL25ldy1zdGF0cyBkaWZmIA0KPiAvdG1wL29sZC1zdGF0cyAvdG1wL25ldy1zdGF0cyBtdiAv
dG1wL25ldy1zdGF0cyAvdG1wL29sZC1zdGF0cw0KPiANCj4gSSBzdWdnZXN0IGp1c3Qgb3V0cHV0
dGluZyB0aGUgc3RhdHMNCj4gDQo+Pj4+Pj4+PiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIEFk
cmFpbi4NCj4gVGhpcyB3YXkgdXNlciBoYXMgdG8gY2FsbCB3cml0ZSB0byBzdG9yZSB0aGUgZXJy
X3N0YXRzIGRhdGEgdG8gL3RtcC9vbGQtc3RhdHMgYW5kICB1c2VyIGhhcyB0byBjYWxsIHJlYWQg
dG8gcmVhZCAvdG1wL29sZC1zdGF0cy4NCg0KT25seSBpZiB5b3UgbmVlZCB0byBzZWUgd2hhdCBo
YXMgY2hhbmdlZA0KDQo+IA0KPiBBbmQgb3VyIGlkZWEgaXMgdXNlciBjYWxsIG9ubHkgcmVhZCB0
byBnZXQgZXJyb3Igc3RhdHMgaW5mby4NCj4gDQo+IFBsZWFzZSBzdWdnZXN0IG1lIHdoaWNoIGlz
IG9rYXkuDQoNClBsZWFzZSBsZXQncyBzdGFydCB3aXRoIGp1c3Qgb3V0cHV0dGluZyB0aGUgc3Rh
dHMuDQoNCj4+Pj4+IFN1cmUuIFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uDQo+IA0KPiBUaGFu
a3MsDQo+IFNhamlkYQkNCj4gDQo+Pg0KPj4+DQo+Pj4+ICsNCj4+Pj4gKwlyZXR1cm4gMDsNCj4+
Pj4gK30NCj4+Pj4gKw0KPj4+PiArREVGSU5FX1NJTVBMRV9BVFRSSUJVVEUobW1jX2Vycl9zdGF0
ZSwgbW1jX2Vycl9zdGF0ZV9nZXQsDQo+Pj4+ICsJCW1tY19lcnJfc3RhdGVfY2xlYXIsICIlbGx1
XG4iKTsNCj4+Pj4gKw0KPj4+PiArc3RhdGljIGludCBtbWNfZXJyX3N0YXRzX3Nob3coc3RydWN0
IHNlcV9maWxlICpmaWxlLCB2b2lkICpkYXRhKSB7DQo+Pj4+ICsJc3RydWN0IG1tY19ob3N0ICpo
b3N0ID0gKHN0cnVjdCBtbWNfaG9zdCAqKWZpbGUtPnByaXZhdGU7DQo+Pj4+ICsNCj4+Pj4gKwlp
ZiAoIWhvc3QpDQo+Pj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPj4+DQo+Pj4gSSB3YXMgdGhpbmtp
bmcgd2UgbmVlZGVkIGEgd2F5IHRvIGRldGVybWluZSB3aGV0aGVyIHN0YXRzIHdlcmUgYmVpbmcg
Y29sbGVjdGVkIGJlY2F1c2Ugbm90IGFsbCBkcml2ZXJzIHdvdWxkIHN1cHBvcnQgaXQgYXQgbGVh
c3QgaW5pdGlhbGx5IGUuZy4NCj4+Pg0KPj4+IAlpZiAoIWhvc3QtPmVycl9zdGF0c19lbmFibGVk
KSB7DQo+Pj4gCQlzZXFfcHJpbnRmKGZpbGUsICJOb3Qgc3VwcG9ydGVkIGJ5IGRyaXZlclxuIik7
DQo+Pj4gCQlyZXR1cm4gMDsNCj4+PiAJfQ0KPj4+DQo+Pj4+Pj4+Pj4+IFlvdSBtZWFuIGRlY2xh
cmUgYW5vdGhlciB2YXJpYWJsZSAoZXJyX3N0YXRzX2VuYWJsZWQpIGFuZCBlbmFibGUgaXQgaW4g
cHJvYmU/DQo+Pg0KPj4gWWVzLCBhbHRob3VnaCBpdCBpcyBub3QgY2xlYXIgaWYgdGhpcyBpcyB0
aGUgc2FtZSBhcyB3aGF0IHlvdSB3YW50IGZyb20gZXJyX3N0YXRlLCBpLmUuIGlzIGVycl9zdGF0
ZSBkaWZmZXJlbnQgZnJvbSBlcnJfc3RhdHNfZW5hYmxlZD8NCj4+DQo+Pj4+Pj4+IFllcywgZXJy
X3N0YXRlIGFuZCBlcnJfc3RhdHNfZW5hYmxlZCBib3RoIGFyZSBkaWZmZXJlbnQuICBlcnJfc3Rh
dGUgd2lsbCBiZSBzZXQgaWYgYW55IGVycm9ycyBoYXBwZW5lZCBpbiBkcml2ZXIgbGV2ZWwuIA0K
Pj4gIGVycl9zdGF0c19lbmFibGVkIHdpbGwgYmUgc2V0ICBpZiBlcnJfc3RhdHMgZmVhdHVyZSBl
bmFibGVkLCAgaWYgYW55IHZlbmRvciB3YW50cyB0byB1c2UgZXJyX3N0YXRzIGZlYXR1cmUgdGhl
eSB3aWxsIHNldCB0aGlzIGVycl9zdGF0c19lbmFibGVkIGluIHRoZWlyIHZlbmRvciBzcGVjaWZp
YyBmaWxlLg0KPj4NCj4+Pg0KPj4+PiArDQo+Pj4+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBDb21t
YW5kIFRpbWVvdXQgT2NjdXJyZWQ6XHQgJWRcbiIsDQo+Pj4+ICsJCSAgIGhvc3QtPmVycl9zdGF0
c1tNTUNfRVJSX0NNRF9USU1FT1VUXSk7DQo+Pj4NCj4+PiBNYXliZSBwdXQgdGhlIGRlc2NyaXB0
aW9ucyBpbiBhbiBhcnJheSBhbmQgaXRlcmF0ZSBlLmcuDQo+Pj4NCj4+PiAJY29uc3QgY2hhciAq
ZGVzY1tNTUNfRVJSX01BWF0gPSB7DQo+Pj4gCQlbTU1DX0VSUl9DTURfVElNRU9VVF0gPSAiQ29t
bWFuZCBUaW1lb3V0IE9jY3VycmVkIiwNCj4+PiAJCWV0Yw0KPj4+IAl9Ow0KPj4+IAlpbnQgaTsN
Cj4+Pg0KPj4+IAlpZiAoIWhvc3QpDQo+Pj4gCQlyZXR1cm4gLUVJTlZBTDsNCj4+Pg0KPj4+IAlm
b3IgKGkgPSAwOyBpIDwgTU1DX0VSUl9NQVg7IGkrKykgew0KPj4+IAkJaWYgKGRlc2NbaV0pDQo+
Pj4gCQkJc2VxX3ByaW50ZihmaWxlLCAiIyAlczpcdCAlZFxuIiwNCj4+PiAJCQkJICAgZGVzY1sx
XSwgaG9zdC0+ZXJyX3N0YXRzW2ldKTsNCj4+PiAJfQ0KPj4+DQo+Pj4+Pj4+Pj4+IFN1cmUNCj4+
Pg0KPj4+PiArDQo+Pj4+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBDb21tYW5kIENSQyBFcnJvcnMg
T2NjdXJyZWQ6XHQgJWRcbiIsDQo+Pj4+ICsJCSAgIGhvc3QtPmVycl9zdGF0c1tNTUNfRVJSX0NN
RF9DUkNdKTsNCj4+Pj4gKw0KPj4+PiArCXNlcV9wcmludGYoZmlsZSwgIiMgRGF0YSBUaW1lb3V0
IE9jY3VycmVkOlx0ICVkXG4iLA0KPj4+PiArCQkgICBob3N0LT5lcnJfc3RhdHNbTU1DX0VSUl9E
QVRfVElNRU9VVF0pOw0KPj4+PiArDQo+Pj4+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBEYXRhIENS
QyBFcnJvcnMgT2NjdXJyZWQ6XHQgJWRcbiIsDQo+Pj4+ICsJCSAgIGhvc3QtPmVycl9zdGF0c1tN
TUNfRVJSX0RBVF9DUkNdKTsNCj4+Pj4gKw0KPj4+PiArCXNlcV9wcmludGYoZmlsZSwgIiMgQXV0
by1DbWQgRXJyb3IgT2NjdXJyZWQ6XHQgJWRcbiIsDQo+Pj4+ICsJCSAgIGhvc3QtPmVycl9zdGF0
c1tNTUNfRVJSX0FETUFdKTsNCj4+Pj4gKw0KPj4+PiArCXNlcV9wcmludGYoZmlsZSwgIiMgQURN
QSBFcnJvciBPY2N1cnJlZDpcdCAlZFxuIiwNCj4+Pj4gKwkJICAgaG9zdC0+ZXJyX3N0YXRzW01N
Q19FUlJfQURNQV0pOw0KPj4+PiArDQo+Pj4+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBUdW5pbmcg
RXJyb3IgT2NjdXJyZWQ6XHQgJWRcbiIsDQo+Pj4+ICsJCSAgIGhvc3QtPmVycl9zdGF0c1tNTUNf
RVJSX1RVTklOR10pOw0KPj4+PiArDQo+Pj4+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBDTURRIFJF
RCBFcnJvcnM6XHRcdCAlZFxuIiwNCj4+Pj4gKwkJICAgaG9zdC0+ZXJyX3N0YXRzW01NQ19FUlJf
Q01EUV9SRURdKTsNCj4+Pj4gKw0KPj4+PiArCXNlcV9wcmludGYoZmlsZSwgIiMgQ01EUSBHQ0Ug
RXJyb3JzOlx0XHQgJWRcbiIsDQo+Pj4+ICsJCSAgIGhvc3QtPmVycl9zdGF0c1tNTUNfRVJSX0NN
RFFfR0NFXSk7DQo+Pj4+ICsNCj4+Pj4gKwlzZXFfcHJpbnRmKGZpbGUsICIjIENNRFEgSUNDRSBF
cnJvcnM6XHRcdCAlZFxuIiwNCj4+Pj4gKwkJICAgaG9zdC0+ZXJyX3N0YXRzW01NQ19FUlJfQ01E
UV9JQ0NFXSk7DQo+Pj4+ICsNCj4+Pj4gKwlzZXFfcHJpbnRmKGZpbGUsICIjIFJlcXVlc3QgVGlt
ZWRvdXQ6XHQgJWRcbiIsDQo+Pj4+ICsJCSAgIGhvc3QtPmVycl9zdGF0c1tNTUNfRVJSX1JFUV9U
SU1FT1VUXSk7DQo+Pj4+ICsNCj4+Pj4gKwlzZXFfcHJpbnRmKGZpbGUsICIjIENNRFEgUmVxdWVz
dCBUaW1lZG91dDpcdCAlZFxuIiwNCj4+Pj4gKwkJICAgaG9zdC0+ZXJyX3N0YXRzW01NQ19FUlJf
Q01EUV9SRVFfVElNRU9VVF0pOw0KPj4+PiArDQo+Pj4+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBJ
Q0UgQ29uZmlnIEVycm9yczpcdFx0ICVkXG4iLA0KPj4+PiArCQkgICBob3N0LT5lcnJfc3RhdHNb
TU1DX0VSUl9JQ0VfQ0ZHXSk7DQo+Pj4+ICsNCj4+Pj4gKwlyZXR1cm4gMDsNCj4+Pj4gK30NCj4+
Pj4gKw0KPj4+PiArc3RhdGljIGludCBtbWNfZXJyX3N0YXRzX29wZW4oc3RydWN0IGlub2RlICpp
bm9kZSwgc3RydWN0IGZpbGUNCj4+Pj4gKypmaWxlKSB7DQo+Pj4+ICsJcmV0dXJuIHNpbmdsZV9v
cGVuKGZpbGUsIG1tY19lcnJfc3RhdHNfc2hvdywgaW5vZGUtPmlfcHJpdmF0ZSk7IH0NCj4+Pj4g
Kw0KPj4+PiArc3RhdGljIHNzaXplX3QgbW1jX2Vycl9zdGF0c193cml0ZShzdHJ1Y3QgZmlsZSAq
ZmlscCwgY29uc3QgY2hhciBfX3VzZXIgKnVidWYsDQo+Pj4+ICsJCQkJICAgc2l6ZV90IGNudCwg
bG9mZl90ICpwcG9zKQ0KPj4+PiArew0KPj4+PiArCXN0cnVjdCBtbWNfaG9zdCAqaG9zdCA9IGZp
bHAtPmZfbWFwcGluZy0+aG9zdC0+aV9wcml2YXRlOw0KPj4+PiArDQo+Pj4+ICsJaWYgKCFob3N0
KQ0KPj4+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+Pj4gKw0KPj4+PiArCXByX2RlYnVnKCIlczog
UmVzZXR0aW5nIE1NQyBlcnJvciBzdGF0aXN0aWNzXG4iLCBfX2Z1bmNfXyk7DQo+Pj4+ICsJbWVt
c2V0KGhvc3QtPmVycl9zdGF0cywgMCwgc2l6ZW9mKGhvc3QtPmVycl9zdGF0cykpOw0KPj4+PiAr
DQo+Pj4+ICsJcmV0dXJuIGNudDsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIGNvbnN0
IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgbW1jX2Vycl9zdGF0c19mb3BzID0gew0KPj4+PiArCS5v
cGVuCT0gbW1jX2Vycl9zdGF0c19vcGVuLA0KPj4+PiArCS5yZWFkCT0gc2VxX3JlYWQsDQo+Pj4+
ICsJLndyaXRlCT0gbW1jX2Vycl9zdGF0c193cml0ZSwNCj4+Pj4gK307DQo+Pj4+ICsNCj4+Pj4g
IHZvaWQgbW1jX2FkZF9ob3N0X2RlYnVnZnMoc3RydWN0IG1tY19ob3N0ICpob3N0KSAgew0KPj4+
PiAgCXN0cnVjdCBkZW50cnkgKnJvb3Q7DQo+Pj4+IEBAIC0yMzYsNiArMzM3LDExIEBAIHZvaWQg
bW1jX2FkZF9ob3N0X2RlYnVnZnMoc3RydWN0IG1tY19ob3N0ICpob3N0KQ0KPj4+PiAgCWRlYnVn
ZnNfY3JlYXRlX2ZpbGVfdW5zYWZlKCJjbG9jayIsIFNfSVJVU1IgfCBTX0lXVVNSLCByb290LCBo
b3N0LA0KPj4+PiAgCQkJCSAgICZtbWNfY2xvY2tfZm9wcyk7DQo+Pj4+ICANCj4+Pj4gKwlkZWJ1
Z2ZzX2NyZWF0ZV9maWxlKCJlcnJfc3RhdGUiLCAwNjAwLCByb290LCBob3N0LA0KPj4+PiArCQkm
bW1jX2Vycl9zdGF0ZSk7DQo+Pj4+ICsJZGVidWdmc19jcmVhdGVfZmlsZSgiZXJyX3N0YXRzIiwg
MDYwMCwgcm9vdCwgaG9zdCwNCj4+Pj4gKwkJJm1tY19lcnJfc3RhdHNfZm9wcyk7DQo+Pj4+ICsN
Cj4+Pj4gICNpZmRlZiBDT05GSUdfRkFJTF9NTUNfUkVRVUVTVA0KPj4+PiAgCWlmIChmYWlsX3Jl
cXVlc3QpDQo+Pj4+ICAJCXNldHVwX2ZhdWx0X2F0dHIoJmZhaWxfZGVmYXVsdF9hdHRyLCBmYWls
X3JlcXVlc3QpOyBkaWZmIC0tZ2l0IA0KPj4+PiBhL2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuYyBi
L2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuYyBpbmRleA0KPj4+PiBiMTVjMDM0Li41MjQzOTI5IDEw
MDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3F1ZXVlLmMNCj4+Pj4gKysrIGIvZHJp
dmVycy9tbWMvY29yZS9xdWV1ZS5jDQo+Pj4+IEBAIC0xMDAsNiArMTAwLDggQEAgc3RhdGljIGVu
dW0gYmxrX2VoX3RpbWVyX3JldHVybiBtbWNfY3FlX3RpbWVkX291dChzdHJ1Y3QgcmVxdWVzdCAq
cmVxKQ0KPj4+PiAgCWVudW0gbW1jX2lzc3VlX3R5cGUgaXNzdWVfdHlwZSA9IG1tY19pc3N1ZV90
eXBlKG1xLCByZXEpOw0KPj4+PiAgCWJvb2wgcmVjb3ZlcnlfbmVlZGVkID0gZmFsc2U7DQo+Pj4+
ICANCj4+Pj4gKwltbWNfZGVidWdmc19lcnJfc3RhdHNfaW5jKGhvc3QsIE1NQ19FUlJfQ01EUV9S
RVFfVElNRU9VVCk7DQo+Pj4+ICsNCj4+Pj4gIAlzd2l0Y2ggKGlzc3VlX3R5cGUpIHsNCj4+Pj4g
IAljYXNlIE1NQ19JU1NVRV9BU1lOQzoNCj4+Pj4gIAljYXNlIE1NQ19JU1NVRV9EQ01EOg0KPj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS5jDQo+Pj4NCj4+PiBJIHRoaW5rIHRoZSBjb3JlIGNoYW5nZXMgc2hvdWxkIGJlIGEg
c2VwYXJhdGUgcGF0Y2ggZnJvbSBzZGhjaS4NCj4+PiBJIHdvdWxkIHByb2JhYmx5IHNwbGl0IGlu
dG8gNDoNCj4+PiAJbW1jIGNvcmUNCj4+PiAJbW1jIGJsb2NrIGRyaXZlcg0KPj4+IAljcWhjaSBk
cml2ZXINCj4+PiAJc2RoY2kgZHJpdmVyDQo+Pj4NCj4+Pj4+Pj4gU3VyZQ0KPj4+DQo+Pj4+IGlu
ZGV4IDA3YzZkYTEuLmQ3NDIwNTEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2kuYw0KPj4+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4+Pj4gQEAgLTEx
Myw2ICsxMTMsNyBAQCB2b2lkIHNkaGNpX2R1bXByZWdzKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0
KQ0KPj4+PiAgCWlmIChob3N0LT5vcHMtPmR1bXBfdmVuZG9yX3JlZ3MpDQo+Pj4+ICAJCWhvc3Qt
Pm9wcy0+ZHVtcF92ZW5kb3JfcmVncyhob3N0KTsNCj4+Pj4gIA0KPj4+PiArCW1tY19kZWJ1Z2Zz
X2Vycl9zdGF0c19lbmFibGUoaG9zdC0+bW1jKTsNCj4+Pg0KPj4+IFdoeSBoZXJlIGFuZCBub3Qg
aW4gZS5nLiBfX3NkaGNpX2FkZF9ob3N0KCkgPw0KPj4+DQo+Pj4+Pj4+IElmIGFueSBlcnJvcnMg
aGFwcGVuZWQgIGluIGRyaXZlciBsZXZlbCB0aGVuIHdlIHdpbGwgY2FsbCBzZGhjaV9kdW1wcmVn
cygpIHJpZ2h0KCBlcnJfc3RhdGUgdHJ1ZSBtZWFucyBzb21lIGVycm9ycyBoYXBwZW5lZCBpbiBk
cml2ZXIgbGV2ZWwgKS4gIFNvIGl0IGlzIGJldHRlciB0byBjYWxsIG1tY19kZWJ1Z2ZzX2Vycl9z
dGF0c19lbmFibGUoKSBoZXJlLg0KPj4NCj4+IFJlZ2lzdGVycyBhcmUgbm90IGR1bXBlZCBmb3Ig
bW9zdCBlcnJvcnMuICBQbGVhc2UgbW92ZSB0aGlzIHRvIF9fc2RoY2lfYWRkX2hvc3QoKS4NCj4+
DQo+Pj4+Pj4gZXJyX3N0YXRlIGlzIHRydWUgbWVhbnMgZXJyb3JzIGhhcHBlbmVkIGluIGRyaXZl
ciBsZXZlbCBhbmQgZm9yIG1vc3Qgb2YgdGhlIGVycm9ycyB3ZSBhcmUgZHVtcGluZyB0aGUgcmVn
aXN0ZXJzLCBzbyBJIGFtIHRoaW5raW5nIGl0IGlzIGJldHRlciB0byBoYXZlIHRoaXMgY2FsbCBp
biBzZGhjaV9kdW1wcmVncygpIG9ubHkuDQo+Pg0KPj4+DQo+Pj4+ICAJU0RIQ0lfRFVNUCgiPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT1cbiIpOw0KPj4+PiAgfQ0K
Pj4+PiAgRVhQT1JUX1NZTUJPTF9HUEwoc2RoY2lfZHVtcHJlZ3MpOw0KPj4+PiBAQCAtMzE1OSw2
ICszMTYwLDcgQEAgc3RhdGljIHZvaWQgc2RoY2lfdGltZW91dF90aW1lcihzdHJ1Y3QgdGltZXJf
bGlzdCAqdCkNCj4+Pj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmaG9zdC0+bG9jaywgZmxhZ3MpOw0K
Pj4+PiAgDQo+Pj4+ICAJaWYgKGhvc3QtPmNtZCAmJiAhc2RoY2lfZGF0YV9saW5lX2NtZChob3N0
LT5jbWQpKSB7DQo+Pj4+ICsJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoaG9zdC0+bW1jLCBN
TUNfRVJSX1JFUV9USU1FT1VUKTsNCj4+Pj4gIAkJcHJfZXJyKCIlczogVGltZW91dCB3YWl0aW5n
IGZvciBoYXJkd2FyZSBjbWQgaW50ZXJydXB0LlxuIiwNCj4+Pj4gIAkJICAgICAgIG1tY19ob3N0
bmFtZShob3N0LT5tbWMpKTsNCj4+Pj4gIAkJc2RoY2lfZHVtcHJlZ3MoaG9zdCk7DQo+Pj4+IEBA
IC0zMTgxLDYgKzMxODMsNyBAQCBzdGF0aWMgdm9pZCBzZGhjaV90aW1lb3V0X2RhdGFfdGltZXIo
c3RydWN0IA0KPj4+PiB0aW1lcl9saXN0ICp0KQ0KPj4+PiAgDQo+Pj4+ICAJaWYgKGhvc3QtPmRh
dGEgfHwgaG9zdC0+ZGF0YV9jbWQgfHwNCj4+Pj4gIAkgICAgKGhvc3QtPmNtZCAmJiBzZGhjaV9k
YXRhX2xpbmVfY21kKGhvc3QtPmNtZCkpKSB7DQo+Pj4+ICsJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0
c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX1JFUV9USU1FT1VUKTsNCj4+Pj4gIAkJcHJfZXJyKCIl
czogVGltZW91dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBpbnRlcnJ1cHQuXG4iLA0KPj4+PiAgCQkg
ICAgICAgbW1jX2hvc3RuYW1lKGhvc3QtPm1tYykpOw0KPj4+PiAgCQlzZGhjaV9kdW1wcmVncyho
b3N0KTsNCj4+Pj4gQEAgLTMyNDAsMTEgKzMyNDMsMTUgQEAgc3RhdGljIHZvaWQgc2RoY2lfY21k
X2lycShzdHJ1Y3Qgc2RoY2lfaG9zdCANCj4+Pj4gKmhvc3QsIHUzMiBpbnRtYXNrLCB1MzIgKmlu
dG1hc2tfcCkNCj4+Pj4gIA0KPj4+PiAgCWlmIChpbnRtYXNrICYgKFNESENJX0lOVF9USU1FT1VU
IHwgU0RIQ0lfSU5UX0NSQyB8DQo+Pj4+ICAJCSAgICAgICBTREhDSV9JTlRfRU5EX0JJVCB8IFNE
SENJX0lOVF9JTkRFWCkpIHsNCj4+Pj4gLQkJaWYgKGludG1hc2sgJiBTREhDSV9JTlRfVElNRU9V
VCkNCj4+Pj4gKwkJaWYgKGludG1hc2sgJiBTREhDSV9JTlRfVElNRU9VVCkgew0KPj4+PiAgCQkJ
aG9zdC0+Y21kLT5lcnJvciA9IC1FVElNRURPVVQ7DQo+Pj4+IC0JCWVsc2UNCj4+Pj4gKwkJCW1t
Y19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX0NNRF9USU1FT1VUKTsN
Cj4+Pj4gKwkJfSBlbHNlIHsNCj4+Pj4gIAkJCWhvc3QtPmNtZC0+ZXJyb3IgPSAtRUlMU0VROw0K
Pj4+PiAtDQo+Pj4+ICsJCQlpZiAoaG9zdC0+Y21kLT5vcGNvZGUgIT0gTU1DX1NFTkRfVFVOSU5H
X0JMT0NLIHx8DQo+Pj4+ICsJCQkJCWhvc3QtPmNtZC0+b3Bjb2RlICE9IE1NQ19TRU5EX1RVTklO
R19CTE9DS19IUzIwMCkNCj4+Pj4gKwkJCQltbWNfZGVidWdmc19lcnJfc3RhdHNfaW5jKGhvc3Qt
Pm1tYywgTU1DX0VSUl9DTURfQ1JDKTsNCj4+Pj4gKwkJfQ0KPj4+PiAgCQkvKiBUcmVhdCBkYXRh
IGNvbW1hbmQgQ1JDIGVycm9yIHRoZSBzYW1lIGFzIGRhdGEgQ1JDIGVycm9yICovDQo+Pj4+ICAJ
CWlmIChob3N0LT5jbWQtPmRhdGEgJiYNCj4+Pj4gIAkJICAgIChpbnRtYXNrICYgKFNESENJX0lO
VF9DUkMgfCBTREhDSV9JTlRfVElNRU9VVCkpID09IEBAIA0KPj4+PiAtMzI2Niw2DQo+Pj4+ICsz
MjczLDcgQEAgc3RhdGljIHZvaWQgc2RoY2lfY21kX2lycShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9z
dCwgdTMyIA0KPj4+PiAraW50bWFzaywgdTMyICppbnRtYXNrX3ApDQo+Pj4+ICAJCQkgIC1FVElN
RURPVVQgOg0KPj4+PiAgCQkJICAtRUlMU0VROw0KPj4+PiAgDQo+Pj4+ICsJCW1tY19kZWJ1Z2Zz
X2Vycl9zdGF0c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX0FVVE9fQ01EKTsNCj4+Pj4gIAkJaWYg
KHNkaGNpX2F1dG9fY21kMjMoaG9zdCwgbXJxKSkgew0KPj4+PiAgCQkJbXJxLT5zYmMtPmVycm9y
ID0gZXJyOw0KPj4+PiAgCQkJX19zZGhjaV9maW5pc2hfbXJxKGhvc3QsIG1ycSk7DQo+Pj4+IEBA
IC0zMzQyLDYgKzMzNTAsNyBAQCBzdGF0aWMgdm9pZCBzZGhjaV9kYXRhX2lycShzdHJ1Y3Qgc2Ro
Y2lfaG9zdCAqaG9zdCwgdTMyIGludG1hc2spDQo+Pj4+ICAJCQlpZiAoaW50bWFzayAmIFNESENJ
X0lOVF9EQVRBX1RJTUVPVVQpIHsNCj4+Pj4gIAkJCQlob3N0LT5kYXRhX2NtZCA9IE5VTEw7DQo+
Pj4+ICAJCQkJZGF0YV9jbWQtPmVycm9yID0gLUVUSU1FRE9VVDsNCj4+Pj4gKwkJCQltbWNfZGVi
dWdmc19lcnJfc3RhdHNfaW5jKGhvc3QtPm1tYywgTU1DX0VSUl9DTURfVElNRU9VVCk7DQo+Pj4+
ICAJCQkJX19zZGhjaV9maW5pc2hfbXJxKGhvc3QsIGRhdGFfY21kLT5tcnEpOw0KPj4+PiAgCQkJ
CXJldHVybjsNCj4+Pj4gIAkJCX0NCj4+Pj4gQEAgLTMzNzUsMTggKzMzODQsMjUgQEAgc3RhdGlj
IHZvaWQgc2RoY2lfZGF0YV9pcnEoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHUzMiBpbnRtYXNr
KQ0KPj4+PiAgCQlyZXR1cm47DQo+Pj4+ICAJfQ0KPj4+PiAgDQo+Pj4+IC0JaWYgKGludG1hc2sg
JiBTREhDSV9JTlRfREFUQV9USU1FT1VUKQ0KPj4+PiArCWlmIChpbnRtYXNrICYgU0RIQ0lfSU5U
X0RBVEFfVElNRU9VVCkgew0KPj4+PiAgCQlob3N0LT5kYXRhLT5lcnJvciA9IC1FVElNRURPVVQ7
DQo+Pj4+ICsJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX0RB
VF9USU1FT1VUKTsNCj4+Pj4gKwl9DQo+Pj4+ICAJZWxzZSBpZiAoaW50bWFzayAmIFNESENJX0lO
VF9EQVRBX0VORF9CSVQpDQo+Pj4+ICAJCWhvc3QtPmRhdGEtPmVycm9yID0gLUVJTFNFUTsNCj4+
Pj4gIAllbHNlIGlmICgoaW50bWFzayAmIFNESENJX0lOVF9EQVRBX0NSQykgJiYNCj4+Pj4gIAkJ
U0RIQ0lfR0VUX0NNRChzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9DT01NQU5EKSkNCj4+Pj4gLQkJ
CSE9IE1NQ19CVVNfVEVTVF9SKQ0KPj4+PiArCQkJIT0gTU1DX0JVU19URVNUX1IpIHsNCj4+Pj4g
IAkJaG9zdC0+ZGF0YS0+ZXJyb3IgPSAtRUlMU0VROw0KPj4+PiArCQlpZiAoaG9zdC0+Y21kLT5v
cGNvZGUgIT0gTU1DX1NFTkRfVFVOSU5HX0JMT0NLIHx8DQo+Pj4+ICsJCQkJaG9zdC0+Y21kLT5v
cGNvZGUgIT0gTU1DX1NFTkRfVFVOSU5HX0JMT0NLX0hTMjAwKQ0KPj4+PiArCQkJbW1jX2RlYnVn
ZnNfZXJyX3N0YXRzX2luYyhob3N0LT5tbWMsIE1NQ19FUlJfREFUX0NSQyk7DQo+Pj4+ICsJfQ0K
Pj4+PiAgCWVsc2UgaWYgKGludG1hc2sgJiBTREhDSV9JTlRfQURNQV9FUlJPUikgew0KPj4+PiAg
CQlwcl9lcnIoIiVzOiBBRE1BIGVycm9yOiAweCUwOHhcbiIsIG1tY19ob3N0bmFtZShob3N0LT5t
bWMpLA0KPj4+PiAgCQkgICAgICAgaW50bWFzayk7DQo+Pj4+ICAJCXNkaGNpX2FkbWFfc2hvd19l
cnJvcihob3N0KTsNCj4+Pj4gKwkJbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhob3N0LT5tbWMs
IE1NQ19FUlJfQURNQSk7DQo+Pj4+ICAJCWhvc3QtPmRhdGEtPmVycm9yID0gLUVJTzsNCj4+Pj4g
IAkJaWYgKGhvc3QtPm9wcy0+YWRtYV93b3JrYXJvdW5kKQ0KPj4+PiAgCQkJaG9zdC0+b3BzLT5h
ZG1hX3dvcmthcm91bmQoaG9zdCwgaW50bWFzayk7IEBAIC0zOTA1LDIwICszOTIxLDMzIA0KPj4+
PiBAQCBib29sIHNkaGNpX2NxZV9pcnEoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHUzMiBpbnRt
YXNrLCBpbnQgKmNtZF9lcnJvciwNCj4+Pj4gIAlpZiAoIWhvc3QtPmNxZV9vbikNCj4+Pj4gIAkJ
cmV0dXJuIGZhbHNlOw0KPj4+PiAgDQo+Pj4+IC0JaWYgKGludG1hc2sgJiAoU0RIQ0lfSU5UX0lO
REVYIHwgU0RIQ0lfSU5UX0VORF9CSVQgfCBTREhDSV9JTlRfQ1JDKSkNCj4+Pj4gKwlpZiAoaW50
bWFzayAmIChTREhDSV9JTlRfSU5ERVggfCBTREhDSV9JTlRfRU5EX0JJVCB8DQo+Pj4+ICtTREhD
SV9JTlRfQ1JDKSkgew0KPj4+PiAgCQkqY21kX2Vycm9yID0gLUVJTFNFUTsNCj4+Pj4gLQllbHNl
IGlmIChpbnRtYXNrICYgU0RIQ0lfSU5UX1RJTUVPVVQpDQo+Pj4+ICsJCWlmIChpbnRtYXNrICYg
U0RIQ0lfSU5UX0NSQykgew0KPj4+PiArCQkJaWYgKGhvc3QtPmNtZC0+b3Bjb2RlICE9IE1NQ19T
RU5EX1RVTklOR19CTE9DSyB8fA0KPj4+PiArCQkJCQlob3N0LT5jbWQtPm9wY29kZSAhPSBNTUNf
U0VORF9UVU5JTkdfQkxPQ0tfSFMyMDApDQo+Pj4+ICsJCQkJbW1jX2RlYnVnZnNfZXJyX3N0YXRz
X2luYyhob3N0LT5tbWMsIE1NQ19FUlJfQ01EX0NSQyk7DQo+Pj4+ICsJCX0NCj4+Pj4gKwl9IGVs
c2UgaWYgKGludG1hc2sgJiBTREhDSV9JTlRfVElNRU9VVCkgew0KPj4+PiAgCQkqY21kX2Vycm9y
ID0gLUVUSU1FRE9VVDsNCj4+Pj4gLQllbHNlDQo+Pj4+ICsJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0
c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX0NNRF9USU1FT1VUKTsNCj4+Pj4gKwl9IGVsc2UNCj4+
Pj4gIAkJKmNtZF9lcnJvciA9IDA7DQo+Pj4+ICANCj4+Pj4gLQlpZiAoaW50bWFzayAmIChTREhD
SV9JTlRfREFUQV9FTkRfQklUIHwgU0RIQ0lfSU5UX0RBVEFfQ1JDKSkNCj4+Pj4gKwlpZiAoaW50
bWFzayAmIChTREhDSV9JTlRfREFUQV9FTkRfQklUIHwgU0RIQ0lfSU5UX0RBVEFfQ1JDKSkgew0K
Pj4+PiAgCQkqZGF0YV9lcnJvciA9IC1FSUxTRVE7DQo+Pj4+IC0JZWxzZSBpZiAoaW50bWFzayAm
IFNESENJX0lOVF9EQVRBX1RJTUVPVVQpDQo+Pj4+ICsJCWlmIChpbnRtYXNrICYgU0RIQ0lfSU5U
X0RBVEFfQ1JDKSB7DQo+Pj4+ICsJCQlpZiAoaG9zdC0+Y21kLT5vcGNvZGUgIT0gTU1DX1NFTkRf
VFVOSU5HX0JMT0NLIHx8DQo+Pj4+ICsJCQkJCWhvc3QtPmNtZC0+b3Bjb2RlICE9IE1NQ19TRU5E
X1RVTklOR19CTE9DS19IUzIwMCkNCj4+Pj4gKwkJCQltbWNfZGVidWdmc19lcnJfc3RhdHNfaW5j
KGhvc3QtPm1tYywgTU1DX0VSUl9EQVRfQ1JDKTsNCj4+Pj4gKwkJfQ0KPj4+PiArCX0gZWxzZSBp
ZiAoaW50bWFzayAmIFNESENJX0lOVF9EQVRBX1RJTUVPVVQpIHsNCj4+Pj4gIAkJKmRhdGFfZXJy
b3IgPSAtRVRJTUVET1VUOw0KPj4+PiAtCWVsc2UgaWYgKGludG1hc2sgJiBTREhDSV9JTlRfQURN
QV9FUlJPUikNCj4+Pj4gKwkJbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhob3N0LT5tbWMsIE1N
Q19FUlJfREFUX1RJTUVPVVQpOw0KPj4+PiArCX0gZWxzZSBpZiAoaW50bWFzayAmIFNESENJX0lO
VF9BRE1BX0VSUk9SKSB7DQo+Pj4+ICAJCSpkYXRhX2Vycm9yID0gLUVJTzsNCj4+Pj4gLQllbHNl
DQo+Pj4+ICsJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX0FE
TUEpOw0KPj4+PiArCX0gZWxzZQ0KPj4+PiAgCQkqZGF0YV9lcnJvciA9IDA7DQo+Pj4+ICANCj4+
Pj4gIAkvKiBDbGVhciBzZWxlY3RlZCBpbnRlcnJ1cHRzLiAqLw0KPj4+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIGIvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIA0KPj4+
PiBpbmRleCA3YWZiNTdjLi5jMjYzZjhmIDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4
L21tYy9ob3N0LmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oDQo+Pj4+IEBA
IC05Myw2ICs5MywyMyBAQCBzdHJ1Y3QgbW1jX2Nsa19waGFzZV9tYXAgew0KPj4+PiAgDQo+Pj4+
ICBzdHJ1Y3QgbW1jX2hvc3Q7DQo+Pj4+ICANCj4+Pj4gK2VudW0gbW1jX2Vycl9zdGF0IHsNCj4+
Pj4gKwlNTUNfRVJSX0NNRF9USU1FT1VULA0KPj4+PiArCU1NQ19FUlJfQ01EX0NSQywNCj4+Pj4g
KwlNTUNfRVJSX0RBVF9USU1FT1VULA0KPj4+PiArCU1NQ19FUlJfREFUX0NSQywNCj4+Pj4gKwlN
TUNfRVJSX0FVVE9fQ01ELA0KPj4+PiArCU1NQ19FUlJfQURNQSwNCj4+Pj4gKwlNTUNfRVJSX1RV
TklORywNCj4+Pj4gKwlNTUNfRVJSX0NNRFFfUkVELA0KPj4+PiArCU1NQ19FUlJfQ01EUV9HQ0Us
DQo+Pj4+ICsJTU1DX0VSUl9DTURRX0lDQ0UsDQo+Pj4+ICsJTU1DX0VSUl9SRVFfVElNRU9VVCwN
Cj4+Pj4gKwlNTUNfRVJSX0NNRFFfUkVRX1RJTUVPVVQsDQo+Pj4+ICsJTU1DX0VSUl9JQ0VfQ0ZH
LA0KPj4+PiArCU1NQ19FUlJfTUFYLA0KPj4+PiArfTsNCj4+Pj4gKw0KPj4+PiAgc3RydWN0IG1t
Y19ob3N0X29wcyB7DQo+Pj4+ICAJLyoNCj4+Pj4gIAkgKiBJdCBpcyBvcHRpb25hbCBmb3IgdGhl
IGhvc3QgdG8gaW1wbGVtZW50IHByZV9yZXEgYW5kIHBvc3RfcmVxIA0KPj4+PiBpbiBAQCAtNTAw
LDYgKzUxNyw4IEBAIHN0cnVjdCBtbWNfaG9zdCB7DQo+Pj4+ICANCj4+Pj4gIAkvKiBIb3N0IFNv
ZnR3YXJlIFF1ZXVlIHN1cHBvcnQgKi8NCj4+Pj4gIAlib29sCQkJaHNxX2VuYWJsZWQ7DQo+Pj4+
ICsJdTMyICAgICAgICAgICAgICAgICAgICAgZXJyX3N0YXRzW01NQ19FUlJfTUFYXTsNCj4+Pg0K
Pj4+IElmIHlvdSBtYWtlIGl0IHU2NCB0aGVuIHdlIGRvbid0IGhhdmUgdG8gdGhpbmsgYWJvdXQg
dGhlIHZhbHVlIG92ZXJmbG93aW5nLg0KPj4+DQo+Pj4+Pj4gU3VyZQ0KPj4+DQo+Pj4+ICsJYm9v
bAkJCWVycl9zdGF0ZTsNCj4+Pj4gIA0KPj4+PiAgCXVuc2lnbmVkIGxvbmcJCXByaXZhdGVbXSBf
X19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+Pj4+ICB9Ow0KPj4+PiBAQCAtNjM1LDYgKzY1NCwyNCBA
QCBzdGF0aWMgaW5saW5lIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9uIG1tY19nZXRfZG1hX2Rpcihz
dHJ1Y3QgbW1jX2RhdGEgKmRhdGEpDQo+Pj4+ICAJcmV0dXJuIGRhdGEtPmZsYWdzICYgTU1DX0RB
VEFfV1JJVEUgPyBETUFfVE9fREVWSUNFIDogDQo+Pj4+IERNQV9GUk9NX0RFVklDRTsgIH0NCj4+
Pj4gIA0KPj4+PiArc3RhdGljIGlubGluZSB2b2lkIG1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19lbmFi
bGUoc3RydWN0IG1tY19ob3N0DQo+Pj4+ICsqbW1jKSB7DQo+Pj4+ICsJbW1jLT5lcnJfc3RhdGUg
PSB0cnVlOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgbW1jX2Rl
YnVnZnNfZXJyX3N0YXRzX2luYyhzdHJ1Y3QgbW1jX2hvc3QgKm1tYywNCj4+Pj4gKwkJZW51bSBt
bWNfZXJyX3N0YXQgc3RhdCkgew0KPj4+PiArDQo+Pj4+ICsJLyoNCj4+Pj4gKwkgKiBJZ25vcmUg
dGhlIGNvbW1hbmQgdGltZW91dCBlcnJvcnMgb2JzZXJ2ZWQgZHVyaW5nDQo+Pj4+ICsJICogdGhl
IGNhcmQgaW5pdCBhcyB0aG9zZSBhcmUgZXhjZXB0ZWQuDQo+Pj4+ICsJICovDQo+Pj4+ICsJaWYg
KCFtbWMtPmVycl9zdGF0ZSkNCj4+Pj4gKwkJbW1jLT5lcnJfc3RhdHNbTU1DX0VSUl9DTURfVElN
RU9VVF0gPSAwOw0KPj4+DQo+Pj4gVGhpcyB3b3VsZCBiZSBiZXR0ZXIgaGFuZGxlZCBpbiB0aGUg
Y2FyZCBpbml0IGNvZGUgc29tZXdoZXJlLCBub3QgaGVyZS4NCj4+Pg0KPj4+Pj4+PiBTdXJlLg0K
Pj4+DQo+Pj4+ICsNCj4+Pj4gKwltbWMtPmVycl9zdGF0c1tzdGF0XSArPSAxOw0KPj4+PiArfQ0K
Pj4+PiArDQo+Pj4+ICBpbnQgbW1jX3NlbmRfdHVuaW5nKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwg
dTMyIG9wY29kZSwgaW50IA0KPj4+PiAqY21kX2Vycm9yKTsgIGludCBtbWNfc2VuZF9hYm9ydF90
dW5pbmcoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1MzIgDQo+Pj4+IG9wY29kZSk7ICBpbnQgbW1j
X2dldF9leHRfY3NkKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwgdTggDQo+Pj4+ICoqbmV3X2V4dF9j
c2QpOw0KPj4+Pg0KPj4+DQo+Pg0KPiANCg0K
