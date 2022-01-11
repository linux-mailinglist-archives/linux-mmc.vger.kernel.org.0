Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7484448B356
	for <lists+linux-mmc@lfdr.de>; Tue, 11 Jan 2022 18:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbiAKRQl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 11 Jan 2022 12:16:41 -0500
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:7776
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343994AbiAKRPr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Jan 2022 12:15:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNS4/qrU7/am/kaOwylLa4Ibm91jH16mFrdXHXNHDt2D30K0yXlI6BaUy4JrotJUm0w1cpalCs3jo7flBM/EgXt7CAOJEljIKSeOCCZtGE587v4DOo11njf7zf78lQzDxho8rynvSYCyBQEuBQkOiBVOqTczCewdcXgIcToZjNrB83mKzuPt1B8iARxsTaeZTyOao31h25DBEMbEJAxN+wRsT1kqs+ITEV5tDbdG69GAtGVHMAeEE/y6jQvt4gr75K5y6QD2s2FLsU85PmtiLDD595P9CVVQqy7NJmuS/B23ZrsSlHM3ffm7ecXAx+/jKQ5kKXLChV+h4OmLeZKy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFggKABoXG4fFmhLOt6RbZE2kU6NMy/5RXFDbxZ6Ne0=;
 b=Uv43SAe2D8Qqlg3bqcXhf2jWbQlciUdkCAxYmiw+luuq9BhjZnqFFXEfO0lLMoNgnvzosBPyyq5zRKydQAjKxHtqSAKyzm0fGq1rMQxTs9fq4MXTZt4oY8K2kiwpcGDIhwDVTQiKZAEs2tBqQRADYS0ePFO9xqzXcENeMtILdU8eZ13gc+lfvTX7xIHC5Es4LrUcJtGC5TzI6hiVMdTdhhg9K2JzLJOB3ky7WmasGs+xa2VYIWUUYIcJB99cfjVRpYwtrlh9tw/33Oo+sR4GXfTTVo/vCWR7bEJ0Q+ny71yt6/JKtE8MYKpvvIMdQbivvK1T1FothpMgc9o4RwexUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFggKABoXG4fFmhLOt6RbZE2kU6NMy/5RXFDbxZ6Ne0=;
 b=ilWLkabirAG1l/oHb6EK/3ozjOJ/SQ3og3Xjm1gDXyXJXKhQ2UAyjQfOhcknJhqPgGvS6+rKFOpemd3HgRTShkLVghr0wSLDudCSGaD3D75KzWrHndQQRtyh2596IAIKY4iqlmb5y6ET7SRFF65mwOYoCq8JFrNLikEVu0jfWA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 17:15:30 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:15:30 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v9 17/24] wfx: add queue.c/queue.h
Date:   Tue, 11 Jan 2022 18:14:17 +0100
Message-Id: <20220111171424.862764-18-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
References: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95bfafd5-995d-4eb3-4c06-08d9d525f845
X-MS-TrafficTypeDiagnostic: PH0PR11MB5657:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB5657492D71323EA3B1B4F37193519@PH0PR11MB5657.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnQr9yuMGn0jKsFsBAm5kLO+FKs8fdqbgez19u+PUP+XpFfHS5j7HAmJPfrHSS95lk1A9hiLhvq1/7CTvPk6jsIK86KYtJRa59N6QAMDNKyb/MUi/IYfEqYZQsyV3GrK6Zn6TJME6oafRglahirbN4hA/+mjSeBNIBI8DBDFjcHhLxjWWwl1Q3PBbNhK3Miq45WIlZYXYJkNcDjSKxhbqFiXqnLFdNmEY/Edh5X3WlcLc+lyE6dM0W/AY3tzsebv16i7D8aYKq4eiQrpdqHq7f9oQWiTcK1zUr/XsnYi59Bu1Mg1cXM5zQd2gKVK9Jo1m/283fKqPGCMg4Sv5T+krppX1zR6qircghlLv+7aysk+5JO2u4s6AgPlHQNUXEpIKuD9JlYnAfrnmNmppSt+x3auDDKN5o4q9qGaEWGXlEMqMERltZKbMcgC09TQoZ/YQ6Z7xnfLX1g0WbDtWh9o4K43gQBrjxaWIp/9BS8MkEQ+KVWAssBDDVeFQskH0LPjE/8y4GYntp3eoX/tPxizqIEzXnWvKMXkJELudTfAAMQ60tEsnECcPkH2jL84KMT0GmysyW6+q4CzZnsA70YozL5o/k7Hw9odMWkN27P04MmlxZUBJphnNcQDIZu097991MyWsRqkp8NZOH5e5y+k6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66574015)(86362001)(5660300002)(8936002)(7416002)(6916009)(8676002)(83380400001)(1076003)(6486002)(36756003)(38100700002)(186003)(66946007)(6666004)(2616005)(4326008)(2906002)(316002)(107886003)(66556008)(66476007)(54906003)(6512007)(508600001)(30864003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFErRTI0ZHNnWmF2dlVHRUFZMEVnWjBmRDlYdG5QWHY5bklTSjA5Y2J2WUJ5?=
 =?utf-8?B?dlhOZVphTnlhbjU4YlNvMlc1T1BNOVY1TjFtVnpFUUI2cFQ1K3ZsWWZINFNV?=
 =?utf-8?B?RklGM2R2SElUZGY1OWtybXlQcnhPaDlDT3d6L3ZHQ0JySFh6aWJWakUrTW5C?=
 =?utf-8?B?NjJpZ0NWa1F1VEhQV3FvTUlBR2F1eUZTUjM1MHdHRXJkYW1zK29DWGhQdFhv?=
 =?utf-8?B?OUo2dEZSU0FqV2J0NzV2MXN6cDBrUEk5ek1qd1BCZ3RqOHRNUEpJZlBjbG5p?=
 =?utf-8?B?TGgzeEJoKzNHRnRPZk1TcXc0MVRZQmJyQlNuQWFvTGhjVHZ6OXhYR0lzMVlj?=
 =?utf-8?B?ZmNwNU1VUXc1OFJHZ3hWeXU5N0g2K2djMVNBVlNhT0YySXAySTJZeHBOOTdO?=
 =?utf-8?B?ZXVmdXl3NS9vbTBxN29sM0JvVmszVDV2Qjl6bnFWZ1ZMd0Z3REZWSXpOQlJl?=
 =?utf-8?B?NXNmMHJMTkUzSVNiRFdTVGNLOE95bVhLOEtmTkVoQmtNak1WSDNZN1RrdDh2?=
 =?utf-8?B?R3dJV3NFU3pJU1B3bmIxbm9wVkxEWk9lcUs3a256aFZjd2wzbGJQMW1keW9J?=
 =?utf-8?B?YmQyNmxSeWFzeUJRRnpKZ1A5UlBEZWdSMGFlTVloTkZXR1g5dWRFbHlGNFJT?=
 =?utf-8?B?Yk9pYVdVTUlWS0Y2WHlWVE93UHdFTnFHeFZZekUwU0M5aC9OaStVbTZ3alFD?=
 =?utf-8?B?Qjlnc1R4aDBwWVRKYkVRanpyc3FxcTRlWDlNbldSS3pETFJkNy9SQlR2OFBO?=
 =?utf-8?B?emFEQ3NXaHBidTBra1hrWUxFWEJSM2h1c2dwWUR2QXIxczdTeEpkR0dEZUhF?=
 =?utf-8?B?VlFDSGtsWXo0ZkVDY0lSWjl0Wlh6Um92L0VTY1N4ZzBFS1lKdUozWVJWY001?=
 =?utf-8?B?NHBzNjJndE5NYi9IMjV5UUc0dUhGd0w5Q2sydEVZcmRaSHYyNXREZmlYMG4r?=
 =?utf-8?B?OVRBLzBPL2RpNG8xaGR4RCs1UVJjU0VpRDRFVjhTV25pY3JSNWpEKzF4TktK?=
 =?utf-8?B?NnpPRlgza01HbGhWeUw5a0dBOFgzWTE2eG9kMHhZTDZFd2dyQUZpSlZJSW1t?=
 =?utf-8?B?eEQ1bzA2eTQzakRIOW5XbnRJSDZUcDdpQjh6T3VLWEg4MkhvSTYyblNkOUF5?=
 =?utf-8?B?eWthQ2tqRkxrY0IyZVBPR1N5UWRFTTRncU11YnowMndOV3lzM01ianJtV0dN?=
 =?utf-8?B?OFVzdWxEbUxhZ3cxU0JYd2hDZXNqR3dHVE04M0tlTTVVeTliOUUxVk81Wjdh?=
 =?utf-8?B?ZWRTUndTczRoeTY5YVNkV3pMYm5qS3B6YkVjV3lMWUl4QVJTY0oxNnkzOHVi?=
 =?utf-8?B?TGRNYk5TTXdaQk5IcUdHU3dYb1dZTVhwTXB4b2M5WTdiL1l3NXR6SDZSOXdp?=
 =?utf-8?B?dzd6SnRvQzZ6Q0NEdzlFUDFTdFNsZC8vcW96eitlbWUza2N3YjRTbGRTbnBt?=
 =?utf-8?B?SlZkQUM1NGIwWWdjaTF0OStzbHk0UkM0YzVHc1BZQzdyUUdmeXdNVG1rbVpu?=
 =?utf-8?B?bnVaa1pUMWs5ZjRETWkrRjdwR091elNOcXAyMW9vdExURmtRSjAzeU80TExs?=
 =?utf-8?B?WW5mb3daSnlHRUM5STRCR0MzWUxDTTQrV3pNN05XRWFteiswV25WdWhOeVdZ?=
 =?utf-8?B?VmZnSS9QNFZWazlEUE4xRkM4VEpsc3hueHV6MkNJK3N2V3h0bmQ4dk5NYzBx?=
 =?utf-8?B?Uk5wb3RnQmw2bDRBTG1tVWZLWE15Vm8zY1A1MHBzN0tUWWRlSi9hQVh2QUs4?=
 =?utf-8?B?RFlNSTRYKyttdWU2MzZLQUdNVlR1QnVNamQ0TmVrc1hLeVpsM2FzdCtBa1RX?=
 =?utf-8?B?S0NZOERqdnM1UG91UFRXTDJpUVNSczN1WnlnS2p0a0hhc0JOVEg0TitQRCtZ?=
 =?utf-8?B?U29EUmpmR24xZHRpVldiSTBMdVVVVzg0ZWEwbSt1L3ZSWi8wdTRsQVFZU1k1?=
 =?utf-8?B?RkdnVkpmYkdlVlRDVC9XM2F6L0xzSmZtTDM0V0NGaHZ3bTJEdEFPSmxKb3Z0?=
 =?utf-8?B?WWdGZVFFWUNjU3ZMOUM3S0J5MnZKdzJOcTVQUmhTNFBiQURMRHNrNjBnSDlq?=
 =?utf-8?B?endyUnZzbmZRbm5KVjhWTWxtTVB0ZFdJalI4MThMY3NrRjFlVEVGeUZRa09y?=
 =?utf-8?B?UllHMWt5WjdpMlhHUTBiTEVteFJGSDRESk96QVdVbG5FR1duYlFWcEgxNFg1?=
 =?utf-8?B?eWxjODA5ODVMQklja2wxdTZ3YnNxR0NxYWlyL1FVNFRoM1VIOXJ5ZU5ra2dx?=
 =?utf-8?Q?dKZ3/sXch7GGUiS70CfdjcHpkAh4jiEMh+7T3c43CA=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bfafd5-995d-4eb3-4c06-08d9d525f845
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:15:30.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8YFKi9yeh9/E1rQvgCecUTkjrxjQyQQHEjXuZburcyNtlinP4/PrboqgHt5K8FRabDFdT+o+r/AX/rx5mRpaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5657
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVldWUuYyB8IDI5OCArKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVl
dWUuaCB8ICA0NCArKysrCiAyIGZpbGVzIGNoYW5nZWQsIDM0MiBpbnNlcnRpb25zKCspCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5o
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uOTE4NjcyNmZmMDdmCi0tLSAvZGV2L251bGwKKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1ZS5jCkBAIC0wLDAgKzEsMjk4IEBA
CisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisvKgorICogUXVldWUg
YmV0d2VlbiB0aGUgdHggb3BlcmF0aW9uIGFuZCB0aGUgYmggd29ya3F1ZXVlLgorICoKKyAqIENv
cHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5jLgorICogQ29w
eXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgorICovCisjaW5jbHVkZSA8bGludXgvc2NoZWQu
aD4KKyNpbmNsdWRlIDxuZXQvbWFjODAyMTEuaD4KKworI2luY2x1ZGUgInF1ZXVlLmgiCisjaW5j
bHVkZSAid2Z4LmgiCisjaW5jbHVkZSAic3RhLmgiCisjaW5jbHVkZSAiZGF0YV90eC5oIgorI2lu
Y2x1ZGUgInRyYWNlcy5oIgorCit2b2lkIHdmeF90eF9sb2NrKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2
KQoreworCWF0b21pY19pbmMoJndkZXYtPnR4X2xvY2spOworfQorCit2b2lkIHdmeF90eF91bmxv
Y2soc3RydWN0IHdmeF9kZXYgKndkZXYpCit7CisJaW50IHR4X2xvY2sgPSBhdG9taWNfZGVjX3Jl
dHVybigmd2Rldi0+dHhfbG9jayk7CisKKwlXQVJOKHR4X2xvY2sgPCAwLCAiaW5jb25zaXN0ZW50
IHR4X2xvY2sgdmFsdWUiKTsKKwlpZiAoIXR4X2xvY2spCisJCXdmeF9iaF9yZXF1ZXN0X3R4KHdk
ZXYpOworfQorCit2b2lkIHdmeF90eF9mbHVzaChzdHJ1Y3Qgd2Z4X2RldiAqd2RldikKK3sKKwlp
bnQgcmV0OworCisJLyogRG8gbm90IHdhaXQgZm9yIGFueSByZXBseSBpZiBjaGlwIGlzIGZyb3pl
biAqLworCWlmICh3ZGV2LT5jaGlwX2Zyb3plbikKKwkJcmV0dXJuOworCisJd2Z4X3R4X2xvY2so
d2Rldik7CisJbXV0ZXhfbG9jaygmd2Rldi0+aGlmX2NtZC5sb2NrKTsKKwlyZXQgPSB3YWl0X2V2
ZW50X3RpbWVvdXQod2Rldi0+aGlmLnR4X2J1ZmZlcnNfZW1wdHksICF3ZGV2LT5oaWYudHhfYnVm
ZmVyc191c2VkLAorCQkJCSBtc2Vjc190b19qaWZmaWVzKDMwMDApKTsKKwlpZiAoIXJldCkgewor
CQlkZXZfd2Fybih3ZGV2LT5kZXYsICJjYW5ub3QgZmx1c2ggdHggYnVmZmVycyAoJWQgc3RpbGwg
YnVzeSlcbiIsCisJCQkgd2Rldi0+aGlmLnR4X2J1ZmZlcnNfdXNlZCk7CisJCXdmeF9wZW5kaW5n
X2R1bXBfb2xkX2ZyYW1lcyh3ZGV2LCAzMDAwKTsKKwkJLyogRklYTUU6IGRyb3AgcGVuZGluZyBm
cmFtZXMgaGVyZSAqLworCQl3ZGV2LT5jaGlwX2Zyb3plbiA9IHRydWU7CisJfQorCW11dGV4X3Vu
bG9jaygmd2Rldi0+aGlmX2NtZC5sb2NrKTsKKwl3ZnhfdHhfdW5sb2NrKHdkZXYpOworfQorCit2
b2lkIHdmeF90eF9sb2NrX2ZsdXNoKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQoreworCXdmeF90eF9s
b2NrKHdkZXYpOworCXdmeF90eF9mbHVzaCh3ZGV2KTsKK30KKwordm9pZCB3ZnhfdHhfcXVldWVz
X2luaXQoc3RydWN0IHdmeF92aWYgKnd2aWYpCit7CisJLyogVGhlIGRldmljZSBpcyBpbiBjaGFy
Z2UgdG8gcmVzcGVjdCB0aGUgZGV0YWlscyBvZiB0aGUgUW9TIHBhcmFtZXRlcnMuIFRoZSBkcml2
ZXIganVzdAorCSAqIGVuc3VyZSB0aGF0IGl0IHJvdWdodGx5IHJlc3BlY3QgdGhlIHByaW9yaXRp
ZXMgdG8gYXZvaWQgYW55IHNob3J0YWdlLgorCSAqLworCWNvbnN0IGludCBwcmlvcml0aWVzW0lF
RUU4MDIxMV9OVU1fQUNTXSA9IHsgMSwgMiwgNjQsIDEyOCB9OworCWludCBpOworCisJZm9yIChp
ID0gMDsgaSA8IElFRUU4MDIxMV9OVU1fQUNTOyArK2kpIHsKKwkJc2tiX3F1ZXVlX2hlYWRfaW5p
dCgmd3ZpZi0+dHhfcXVldWVbaV0ubm9ybWFsKTsKKwkJc2tiX3F1ZXVlX2hlYWRfaW5pdCgmd3Zp
Zi0+dHhfcXVldWVbaV0uY2FiKTsKKwkJd3ZpZi0+dHhfcXVldWVbaV0ucHJpb3JpdHkgPSBwcmlv
cml0aWVzW2ldOworCX0KK30KKworYm9vbCB3ZnhfdHhfcXVldWVfZW1wdHkoc3RydWN0IHdmeF92
aWYgKnd2aWYsIHN0cnVjdCB3ZnhfcXVldWUgKnF1ZXVlKQoreworCXJldHVybiBza2JfcXVldWVf
ZW1wdHlfbG9ja2xlc3MoJnF1ZXVlLT5ub3JtYWwpICYmIHNrYl9xdWV1ZV9lbXB0eV9sb2NrbGVz
cygmcXVldWUtPmNhYik7Cit9CisKK3ZvaWQgd2Z4X3R4X3F1ZXVlc19jaGVja19lbXB0eShzdHJ1
Y3Qgd2Z4X3ZpZiAqd3ZpZikKK3sKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBJRUVFODAy
MTFfTlVNX0FDUzsgKytpKSB7CisJCVdBUk5fT04oYXRvbWljX3JlYWQoJnd2aWYtPnR4X3F1ZXVl
W2ldLnBlbmRpbmdfZnJhbWVzKSk7CisJCVdBUk5fT04oIXdmeF90eF9xdWV1ZV9lbXB0eSh3dmlm
LCAmd3ZpZi0+dHhfcXVldWVbaV0pKTsKKwl9Cit9CisKK3N0YXRpYyB2b2lkIF9fd2Z4X3R4X3F1
ZXVlX2Ryb3Aoc3RydWN0IHdmeF92aWYgKnd2aWYsCisJCQkJc3RydWN0IHNrX2J1ZmZfaGVhZCAq
c2tiX3F1ZXVlLCBzdHJ1Y3Qgc2tfYnVmZl9oZWFkICpkcm9wcGVkKQoreworCXN0cnVjdCBza19i
dWZmICpza2IsICp0bXA7CisKKwlzcGluX2xvY2tfYmgoJnNrYl9xdWV1ZS0+bG9jayk7CisJc2ti
X3F1ZXVlX3dhbGtfc2FmZShza2JfcXVldWUsIHNrYiwgdG1wKSB7CisJCV9fc2tiX3VubGluayhz
a2IsIHNrYl9xdWV1ZSk7CisJCXNrYl9xdWV1ZV9oZWFkKGRyb3BwZWQsIHNrYik7CisJfQorCXNw
aW5fdW5sb2NrX2JoKCZza2JfcXVldWUtPmxvY2spOworfQorCit2b2lkIHdmeF90eF9xdWV1ZV9k
cm9wKHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBzdHJ1Y3Qgd2Z4X3F1ZXVlICpxdWV1ZSwKKwkJICAg
ICAgIHN0cnVjdCBza19idWZmX2hlYWQgKmRyb3BwZWQpCit7CisJX193ZnhfdHhfcXVldWVfZHJv
cCh3dmlmLCAmcXVldWUtPmNhYiwgZHJvcHBlZCk7CisJX193ZnhfdHhfcXVldWVfZHJvcCh3dmlm
LCAmcXVldWUtPm5vcm1hbCwgZHJvcHBlZCk7CisJd2FrZV91cCgmd3ZpZi0+d2Rldi0+dHhfZGVx
dWV1ZSk7Cit9CisKK3ZvaWQgd2Z4X3R4X3F1ZXVlc19wdXQoc3RydWN0IHdmeF92aWYgKnd2aWYs
IHN0cnVjdCBza19idWZmICpza2IpCit7CisJc3RydWN0IHdmeF9xdWV1ZSAqcXVldWUgPSAmd3Zp
Zi0+dHhfcXVldWVbc2tiX2dldF9xdWV1ZV9tYXBwaW5nKHNrYildOworCXN0cnVjdCBpZWVlODAy
MTFfdHhfaW5mbyAqdHhfaW5mbyA9IElFRUU4MDIxMV9TS0JfQ0Ioc2tiKTsKKworCWlmICh0eF9p
bmZvLT5mbGFncyAmIElFRUU4MDIxMV9UWF9DVExfU0VORF9BRlRFUl9EVElNKQorCQlza2JfcXVl
dWVfdGFpbCgmcXVldWUtPmNhYiwgc2tiKTsKKwllbHNlCisJCXNrYl9xdWV1ZV90YWlsKCZxdWV1
ZS0+bm9ybWFsLCBza2IpOworfQorCit2b2lkIHdmeF9wZW5kaW5nX2Ryb3Aoc3RydWN0IHdmeF9k
ZXYgKndkZXYsIHN0cnVjdCBza19idWZmX2hlYWQgKmRyb3BwZWQpCit7CisJc3RydWN0IHdmeF9x
dWV1ZSAqcXVldWU7CisJc3RydWN0IHdmeF92aWYgKnd2aWY7CisJc3RydWN0IHdmeF9oaWZfbXNn
ICpoaWY7CisJc3RydWN0IHNrX2J1ZmYgKnNrYjsKKworCVdBUk4oIXdkZXYtPmNoaXBfZnJvemVu
LCAiJXMgc2hvdWxkIG9ubHkgYmUgdXNlZCB0byByZWNvdmVyIGEgZnJvemVuIGRldmljZSIsIF9f
ZnVuY19fKTsKKwl3aGlsZSAoKHNrYiA9IHNrYl9kZXF1ZXVlKCZ3ZGV2LT50eF9wZW5kaW5nKSkg
IT0gTlVMTCkgeworCQloaWYgPSAoc3RydWN0IHdmeF9oaWZfbXNnICopc2tiLT5kYXRhOworCQl3
dmlmID0gd2Rldl90b193dmlmKHdkZXYsIGhpZi0+aW50ZXJmYWNlKTsKKwkJaWYgKHd2aWYpIHsK
KwkJCXF1ZXVlID0gJnd2aWYtPnR4X3F1ZXVlW3NrYl9nZXRfcXVldWVfbWFwcGluZyhza2IpXTsK
KwkJCVdBUk5fT04oc2tiX2dldF9xdWV1ZV9tYXBwaW5nKHNrYikgPiAzKTsKKwkJCVdBUk5fT04o
IWF0b21pY19yZWFkKCZxdWV1ZS0+cGVuZGluZ19mcmFtZXMpKTsKKwkJCWF0b21pY19kZWMoJnF1
ZXVlLT5wZW5kaW5nX2ZyYW1lcyk7CisJCX0KKwkJc2tiX3F1ZXVlX2hlYWQoZHJvcHBlZCwgc2ti
KTsKKwl9Cit9CisKK3N0cnVjdCBza19idWZmICp3ZnhfcGVuZGluZ19nZXQoc3RydWN0IHdmeF9k
ZXYgKndkZXYsIHUzMiBwYWNrZXRfaWQpCit7CisJc3RydWN0IHdmeF9xdWV1ZSAqcXVldWU7CisJ
c3RydWN0IHdmeF9oaWZfcmVxX3R4ICpyZXE7CisJc3RydWN0IHdmeF92aWYgKnd2aWY7CisJc3Ry
dWN0IHdmeF9oaWZfbXNnICpoaWY7CisJc3RydWN0IHNrX2J1ZmYgKnNrYjsKKworCXNwaW5fbG9j
a19iaCgmd2Rldi0+dHhfcGVuZGluZy5sb2NrKTsKKwlza2JfcXVldWVfd2Fsaygmd2Rldi0+dHhf
cGVuZGluZywgc2tiKSB7CisJCWhpZiA9IChzdHJ1Y3Qgd2Z4X2hpZl9tc2cgKilza2ItPmRhdGE7
CisJCXJlcSA9IChzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKiloaWYtPmJvZHk7CisJCWlmIChyZXEt
PnBhY2tldF9pZCAhPSBwYWNrZXRfaWQpCisJCQljb250aW51ZTsKKwkJc3Bpbl91bmxvY2tfYmgo
JndkZXYtPnR4X3BlbmRpbmcubG9jayk7CisJCXd2aWYgPSB3ZGV2X3RvX3d2aWYod2RldiwgaGlm
LT5pbnRlcmZhY2UpOworCQlpZiAod3ZpZikgeworCQkJcXVldWUgPSAmd3ZpZi0+dHhfcXVldWVb
c2tiX2dldF9xdWV1ZV9tYXBwaW5nKHNrYildOworCQkJV0FSTl9PTihza2JfZ2V0X3F1ZXVlX21h
cHBpbmcoc2tiKSA+IDMpOworCQkJV0FSTl9PTighYXRvbWljX3JlYWQoJnF1ZXVlLT5wZW5kaW5n
X2ZyYW1lcykpOworCQkJYXRvbWljX2RlYygmcXVldWUtPnBlbmRpbmdfZnJhbWVzKTsKKwkJfQor
CQlza2JfdW5saW5rKHNrYiwgJndkZXYtPnR4X3BlbmRpbmcpOworCQlyZXR1cm4gc2tiOworCX0K
KwlzcGluX3VubG9ja19iaCgmd2Rldi0+dHhfcGVuZGluZy5sb2NrKTsKKwlXQVJOKDEsICJjYW5u
b3QgZmluZCBwYWNrZXQgaW4gcGVuZGluZyBxdWV1ZSIpOworCXJldHVybiBOVUxMOworfQorCit2
b2lkIHdmeF9wZW5kaW5nX2R1bXBfb2xkX2ZyYW1lcyhzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdW5z
aWduZWQgaW50IGxpbWl0X21zKQoreworCWt0aW1lX3Qgbm93ID0ga3RpbWVfZ2V0KCk7CisJc3Ry
dWN0IHdmeF90eF9wcml2ICp0eF9wcml2OworCXN0cnVjdCB3ZnhfaGlmX3JlcV90eCAqcmVxOwor
CXN0cnVjdCBza19idWZmICpza2I7CisJYm9vbCBmaXJzdCA9IHRydWU7CisKKwlzcGluX2xvY2tf
YmgoJndkZXYtPnR4X3BlbmRpbmcubG9jayk7CisJc2tiX3F1ZXVlX3dhbGsoJndkZXYtPnR4X3Bl
bmRpbmcsIHNrYikgeworCQl0eF9wcml2ID0gd2Z4X3NrYl90eF9wcml2KHNrYik7CisJCXJlcSA9
IHdmeF9za2JfdHhyZXEoc2tiKTsKKwkJaWYgKGt0aW1lX2FmdGVyKG5vdywga3RpbWVfYWRkX21z
KHR4X3ByaXYtPnhtaXRfdGltZXN0YW1wLCBsaW1pdF9tcykpKSB7CisJCQlpZiAoZmlyc3QpIHsK
KwkJCQlkZXZfaW5mbyh3ZGV2LT5kZXYsICJmcmFtZXMgc3R1Y2sgaW4gZmlybXdhcmUgc2luY2Ug
JWRtcyBvciBtb3JlOlxuIiwKKwkJCQkJIGxpbWl0X21zKTsKKwkJCQlmaXJzdCA9IGZhbHNlOwor
CQkJfQorCQkJZGV2X2luZm8od2Rldi0+ZGV2LCAiICAgaWQgJTA4eCBzZW50ICVsbGRtcyBhZ29c
biIsCisJCQkJIHJlcS0+cGFja2V0X2lkLCBrdGltZV9tc19kZWx0YShub3csIHR4X3ByaXYtPnht
aXRfdGltZXN0YW1wKSk7CisJCX0KKwl9CisJc3Bpbl91bmxvY2tfYmgoJndkZXYtPnR4X3BlbmRp
bmcubG9jayk7Cit9CisKK3Vuc2lnbmVkIGludCB3ZnhfcGVuZGluZ19nZXRfcGt0X3VzX2RlbGF5
KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQoreworCWt0aW1lX3Qg
bm93ID0ga3RpbWVfZ2V0KCk7CisJc3RydWN0IHdmeF90eF9wcml2ICp0eF9wcml2ID0gd2Z4X3Nr
Yl90eF9wcml2KHNrYik7CisKKwlyZXR1cm4ga3RpbWVfdXNfZGVsdGEobm93LCB0eF9wcml2LT54
bWl0X3RpbWVzdGFtcCk7Cit9CisKK2Jvb2wgd2Z4X3R4X3F1ZXVlc19oYXNfY2FiKHN0cnVjdCB3
ZnhfdmlmICp3dmlmKQoreworCWludCBpOworCisJaWYgKHd2aWYtPnZpZi0+dHlwZSAhPSBOTDgw
MjExX0lGVFlQRV9BUCkKKwkJcmV0dXJuIGZhbHNlOworCWZvciAoaSA9IDA7IGkgPCBJRUVFODAy
MTFfTlVNX0FDUzsgKytpKQorCQkvKiBOb3RlOiBzaW5jZSBvbmx5IEFQIGNhbiBoYXZlIG1jYXN0
IGZyYW1lcyBpbiBxdWV1ZSBhbmQgb25seQorCQkgKiBvbmUgdmlmIGNhbiBiZSBBUCwgYWxsIHF1
ZXVlZCBmcmFtZXMgaGFzIHNhbWUgaW50ZXJmYWNlIGlkCisJCSAqLworCQlpZiAoIXNrYl9xdWV1
ZV9lbXB0eV9sb2NrbGVzcygmd3ZpZi0+dHhfcXVldWVbaV0uY2FiKSkKKwkJCXJldHVybiB0cnVl
OworCXJldHVybiBmYWxzZTsKK30KKworc3RhdGljIGludCB3ZnhfdHhfcXVldWVfZ2V0X3dlaWdo
dChzdHJ1Y3Qgd2Z4X3F1ZXVlICpxdWV1ZSkKK3sKKwlyZXR1cm4gYXRvbWljX3JlYWQoJnF1ZXVl
LT5wZW5kaW5nX2ZyYW1lcykgKiBxdWV1ZS0+cHJpb3JpdHk7Cit9CisKK3N0YXRpYyBzdHJ1Y3Qg
c2tfYnVmZiAqd2Z4X3R4X3F1ZXVlc19nZXRfc2tiKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQorewor
CXN0cnVjdCB3ZnhfcXVldWUgKnF1ZXVlc1tJRUVFODAyMTFfTlVNX0FDUyAqIEFSUkFZX1NJWkUo
d2Rldi0+dmlmKV07CisJaW50IGksIGosIG51bV9xdWV1ZXMgPSAwOworCXN0cnVjdCB3Znhfdmlm
ICp3dmlmOworCXN0cnVjdCB3ZnhfaGlmX21zZyAqaGlmOworCXN0cnVjdCBza19idWZmICpza2I7
CisKKwkvKiBzb3J0IHRoZSBxdWV1ZXMgKi8KKwl3dmlmID0gTlVMTDsKKwl3aGlsZSAoKHd2aWYg
PSB3dmlmX2l0ZXJhdGUod2Rldiwgd3ZpZikpICE9IE5VTEwpIHsKKwkJZm9yIChpID0gMDsgaSA8
IElFRUU4MDIxMV9OVU1fQUNTOyBpKyspIHsKKwkJCVdBUk5fT04obnVtX3F1ZXVlcyA+PSBBUlJB
WV9TSVpFKHF1ZXVlcykpOworCQkJcXVldWVzW251bV9xdWV1ZXNdID0gJnd2aWYtPnR4X3F1ZXVl
W2ldOworCQkJZm9yIChqID0gbnVtX3F1ZXVlczsgaiA+IDA7IGotLSkKKwkJCQlpZiAod2Z4X3R4
X3F1ZXVlX2dldF93ZWlnaHQocXVldWVzW2pdKSA8CisJCQkJICAgIHdmeF90eF9xdWV1ZV9nZXRf
d2VpZ2h0KHF1ZXVlc1tqIC0gMV0pKQorCQkJCQlzd2FwKHF1ZXVlc1tqIC0gMV0sIHF1ZXVlc1tq
XSk7CisJCQludW1fcXVldWVzKys7CisJCX0KKwl9CisKKwl3dmlmID0gTlVMTDsKKwl3aGlsZSAo
KHd2aWYgPSB3dmlmX2l0ZXJhdGUod2Rldiwgd3ZpZikpICE9IE5VTEwpIHsKKwkJaWYgKCF3dmlm
LT5hZnRlcl9kdGltX3R4X2FsbG93ZWQpCisJCQljb250aW51ZTsKKwkJZm9yIChpID0gMDsgaSA8
IG51bV9xdWV1ZXM7IGkrKykgeworCQkJc2tiID0gc2tiX2RlcXVldWUoJnF1ZXVlc1tpXS0+Y2Fi
KTsKKwkJCWlmICghc2tiKQorCQkJCWNvbnRpbnVlOworCQkJLyogTm90ZTogc2luY2Ugb25seSBB
UCBjYW4gaGF2ZSBtY2FzdCBmcmFtZXMgaW4gcXVldWUKKwkJCSAqIGFuZCBvbmx5IG9uZSB2aWYg
Y2FuIGJlIEFQLCBhbGwgcXVldWVkIGZyYW1lcyBoYXMKKwkJCSAqIHNhbWUgaW50ZXJmYWNlIGlk
CisJCQkgKi8KKwkJCWhpZiA9IChzdHJ1Y3Qgd2Z4X2hpZl9tc2cgKilza2ItPmRhdGE7CisJCQlX
QVJOX09OKGhpZi0+aW50ZXJmYWNlICE9IHd2aWYtPmlkKTsKKwkJCVdBUk5fT04ocXVldWVzW2ld
ICE9ICZ3dmlmLT50eF9xdWV1ZVtza2JfZ2V0X3F1ZXVlX21hcHBpbmcoc2tiKV0pOworCQkJYXRv
bWljX2luYygmcXVldWVzW2ldLT5wZW5kaW5nX2ZyYW1lcyk7CisJCQl0cmFjZV9xdWV1ZXNfc3Rh
dHMod2RldiwgcXVldWVzW2ldKTsKKwkJCXJldHVybiBza2I7CisJCX0KKwkJLyogTm8gbW9yZSBt
dWx0aWNhc3QgdG8gc2VudCAqLworCQl3dmlmLT5hZnRlcl9kdGltX3R4X2FsbG93ZWQgPSBmYWxz
ZTsKKwkJc2NoZWR1bGVfd29yaygmd3ZpZi0+dXBkYXRlX3RpbV93b3JrKTsKKwl9CisKKwlmb3Ig
KGkgPSAwOyBpIDwgbnVtX3F1ZXVlczsgaSsrKSB7CisJCXNrYiA9IHNrYl9kZXF1ZXVlKCZxdWV1
ZXNbaV0tPm5vcm1hbCk7CisJCWlmIChza2IpIHsKKwkJCWF0b21pY19pbmMoJnF1ZXVlc1tpXS0+
cGVuZGluZ19mcmFtZXMpOworCQkJdHJhY2VfcXVldWVzX3N0YXRzKHdkZXYsIHF1ZXVlc1tpXSk7
CisJCQlyZXR1cm4gc2tiOworCQl9CisJfQorCXJldHVybiBOVUxMOworfQorCitzdHJ1Y3Qgd2Z4
X2hpZl9tc2cgKndmeF90eF9xdWV1ZXNfZ2V0KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQoreworCXN0
cnVjdCB3ZnhfdHhfcHJpdiAqdHhfcHJpdjsKKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOworCisJaWYg
KGF0b21pY19yZWFkKCZ3ZGV2LT50eF9sb2NrKSkKKwkJcmV0dXJuIE5VTEw7CisJc2tiID0gd2Z4
X3R4X3F1ZXVlc19nZXRfc2tiKHdkZXYpOworCWlmICghc2tiKQorCQlyZXR1cm4gTlVMTDsKKwlz
a2JfcXVldWVfdGFpbCgmd2Rldi0+dHhfcGVuZGluZywgc2tiKTsKKwl3YWtlX3VwKCZ3ZGV2LT50
eF9kZXF1ZXVlKTsKKwl0eF9wcml2ID0gd2Z4X3NrYl90eF9wcml2KHNrYik7CisJdHhfcHJpdi0+
eG1pdF90aW1lc3RhbXAgPSBrdGltZV9nZXQoKTsKKwlyZXR1cm4gKHN0cnVjdCB3ZnhfaGlmX21z
ZyAqKXNrYi0+ZGF0YTsKK30KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvcXVldWUuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVldWUuaApu
ZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjQ3MzFkZWJjYTkzZAotLS0g
L2Rldi9udWxsCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVldWUuaApA
QCAtMCwwICsxLDQ0IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5
ICovCisvKgorICogUXVldWUgYmV0d2VlbiB0aGUgdHggb3BlcmF0aW9uIGFuZCB0aGUgYmggd29y
a3F1ZXVlLgorICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExhYm9yYXRv
cmllcywgSW5jLgorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgorICovCisjaWZu
ZGVmIFdGWF9RVUVVRV9ICisjZGVmaW5lIFdGWF9RVUVVRV9ICisKKyNpbmNsdWRlIDxsaW51eC9z
a2J1ZmYuaD4KKyNpbmNsdWRlIDxsaW51eC9hdG9taWMuaD4KKworc3RydWN0IHdmeF9kZXY7Citz
dHJ1Y3Qgd2Z4X3ZpZjsKKworc3RydWN0IHdmeF9xdWV1ZSB7CisJc3RydWN0IHNrX2J1ZmZfaGVh
ZCBub3JtYWw7CisJc3RydWN0IHNrX2J1ZmZfaGVhZCBjYWI7IC8qIENvbnRlbnQgQWZ0ZXIgKERU
SU0pIEJlYWNvbiAqLworCWF0b21pY190ICAgICAgICAgICAgcGVuZGluZ19mcmFtZXM7CisJaW50
ICAgICAgICAgICAgICAgICBwcmlvcml0eTsKK307CisKK3ZvaWQgd2Z4X3R4X2xvY2soc3RydWN0
IHdmeF9kZXYgKndkZXYpOwordm9pZCB3ZnhfdHhfdW5sb2NrKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2
KTsKK3ZvaWQgd2Z4X3R4X2ZsdXNoKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KTsKK3ZvaWQgd2Z4X3R4
X2xvY2tfZmx1c2goc3RydWN0IHdmeF9kZXYgKndkZXYpOworCit2b2lkIHdmeF90eF9xdWV1ZXNf
aW5pdChzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZik7Cit2b2lkIHdmeF90eF9xdWV1ZXNfY2hlY2tfZW1w
dHkoc3RydWN0IHdmeF92aWYgKnd2aWYpOworYm9vbCB3ZnhfdHhfcXVldWVzX2hhc19jYWIoc3Ry
dWN0IHdmeF92aWYgKnd2aWYpOwordm9pZCB3ZnhfdHhfcXVldWVzX3B1dChzdHJ1Y3Qgd2Z4X3Zp
ZiAqd3ZpZiwgc3RydWN0IHNrX2J1ZmYgKnNrYik7CitzdHJ1Y3Qgd2Z4X2hpZl9tc2cgKndmeF90
eF9xdWV1ZXNfZ2V0KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KTsKKworYm9vbCB3ZnhfdHhfcXVldWVf
ZW1wdHkoc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCB3ZnhfcXVldWUgKnF1ZXVlKTsKK3Zv
aWQgd2Z4X3R4X3F1ZXVlX2Ryb3Aoc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCB3ZnhfcXVl
dWUgKnF1ZXVlLAorCQkgICAgICAgc3RydWN0IHNrX2J1ZmZfaGVhZCAqZHJvcHBlZCk7CisKK3N0
cnVjdCBza19idWZmICp3ZnhfcGVuZGluZ19nZXQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiBw
YWNrZXRfaWQpOwordm9pZCB3ZnhfcGVuZGluZ19kcm9wKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBz
dHJ1Y3Qgc2tfYnVmZl9oZWFkICpkcm9wcGVkKTsKK3Vuc2lnbmVkIGludCB3ZnhfcGVuZGluZ19n
ZXRfcGt0X3VzX2RlbGF5KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
KTsKK3ZvaWQgd2Z4X3BlbmRpbmdfZHVtcF9vbGRfZnJhbWVzKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2
LCB1bnNpZ25lZCBpbnQgbGltaXRfbXMpOworCisjZW5kaWYKLS0gCjIuMzQuMQoK
