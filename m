Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E147BA92
	for <lists+linux-mmc@lfdr.de>; Tue, 21 Dec 2021 08:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhLUHQY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Dec 2021 02:16:24 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:50166 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhLUHQY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 02:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1640070984; x=1640675784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xpNdpoXu7fJoGlrg4pGK12d3tfjamvKbs8INZgAgHTo=;
  b=vBb+LdszLIQxDWjaPWvEFrw5lE+MuhQzVDXqDDR+9/70tUoYIL6r6cWf
   DdFALK1L1JCAakTJBExaFOwckGhdoDFUzJUOii8BHh3j/eGEuiz5Q0Zwd
   j0yMtw3MUWQE0vL2B9kAntwz4s3Yeu0P88/jIZGu4gKGu/pO0IJg5vJCW
   Y=;
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btxDQQa87qz5WWFTzM3+ivxuL0udjb59ODFfY6Epr31yOffSkQAsr4FdY02KSRIcQPrMUS0ZGt1UAHf/uTLWXwzzZEsHSlSFcDKy53QnM5kiHNcpIhPpY5cOPL13ybJtN3Gj4VhLHx33W7gpL3JawTBcVvvRYM23R+49Yu1kJ2fkAkRqXPPrS2nroHHrdEJeX48A8wnKhP4L5ylKBLTAIdehyV7qQpOghuEyryt1Cqnt8Kw4iNMNIsSPowKqKGfTSGpSkOypjlsmg8W1mmibb5htMCZ17CY6MVGCTjjI2Lo/vuF0wEpuYkk30EL4WHF+IMRyZMLocPaKxh7OLw6y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpNdpoXu7fJoGlrg4pGK12d3tfjamvKbs8INZgAgHTo=;
 b=Z/bEBaJDrScWG9IUkUIZsyK0Vuf8sQyVgqUXFBaEEGM+uM0zRSP4pW1EUcSBREt+vozrINaVh04YY9NBRic3coj8BVYbeqUcATfdEbynYJjZ6JxdVgA6vfG9YZ7pnixjBU1oVpzq373hIqLQgd3QHYimkB7w5RUk4vwQlNhwtG/pKYxh69OKBede28o2TOywWvWYyqYs0IJ+uORrAaGiowQYXiVbn8GhOXFPBuuCI00Eh7JSTbqXCCikkqT6eDMlp2VM5qfr0yzw6sWrmHwxgmyZWX7VjfHSBjbfsCKrGVRtfEg+13KgjNRTMz89dLJTpJNcfxftEhZ0OanMwGWp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by SJ0PR02MB7135.namprd02.prod.outlook.com (2603:10b6:a03:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 07:16:18 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::e4c9:c9c8:1b83:7a65]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::e4c9:c9c8:1b83:7a65%5]) with mapi id 15.20.4801.022; Tue, 21 Dec 2021
 07:16:17 +0000
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
Thread-Index: AQHX8Piwwz+Wb66W+kWR6ItlPnzKnKwzlxCAgAj8QUA=
Date:   Tue, 21 Dec 2021 07:16:17 +0000
Message-ID: <SJ0PR02MB84499B152C13E541E19DBFB4CD7C9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1639492863-7053-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <9fbec373-e667-b4a5-4b92-741f9dd2b7ee@intel.com>
In-Reply-To: <9fbec373-e667-b4a5-4b92-741f9dd2b7ee@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4917268-264e-4af6-a2d6-08d9c451c80c
x-ms-traffictypediagnostic: SJ0PR02MB7135:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB7135C522CDCB0075CA62DA3BB17C9@SJ0PR02MB7135.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRASJfDybMnTaY3jVxnZCkmf6REVD9iDA2cXRBDe1wFUAKOgE1Xy6y0TAruEmxffPgBHXc3sx2sxhZtV/L8S+vXXU5lCXMpl0QvSHq9/xW0AUPMtwCIOtg2SCf7kJE2h4PopjOgX4ZSvD6d3hya0yU3LpeuF8OkrPVqKvSrqA69mLVD1GEN+ZfAAI+ym9KSx83giseZeZfRjvsP/ST+kcL6U/BiYpC53shS8h4cU8UzFia71AgXSJjJyuG/xgZgE2sR3Xlr121ke7WcIqfdARHRz0+pjYsrMGyVJoiE7NgnrJUAThVc8HCEMHgV/E0YjYuQISh94bXFoAG/t0f+i1UUzfZ+8jJaD4D0DKLgDeUPDqD/WMxKn9diFV/Sd5819/qhxTzj44RLl7PmcKnbY8VsjfW1LJO3Y3/2TxLL3NIsZ4MlMKrJQCjq7PDFs8ndD8sRmMp+o4gKkKFT58FTK+GcRbWXpMTUf+LiQCXV0Ut/HhXHpHUhFuwWOh5T5V8QTwhwv00q5PZshnzwqVGOS2fel/C2sCtl8AlpzM52Gnc8atmoBUuRKb2B/bN33KB6OCeiljmwcF9bSBJ02n3y1WZIAEHDI1wNDxM5Y2Ab/IJ07nnfZwcp1RFscSoVXRnuihg5xL8adcO1OsLuIbSClH0XOsG6xQSuNbmGnFAvbcYqdzFfi6nY4pWhCQYOpYZzZ27Dn4sT84/H5fSV/+6Ym+jrJTa8darkn7/oZmnbs8DU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(7416002)(53546011)(55016003)(921005)(316002)(5660300002)(26005)(186003)(6506007)(54906003)(7696005)(110136005)(508600001)(2906002)(86362001)(52536014)(4326008)(8936002)(30864003)(71200400001)(8676002)(38100700002)(33656002)(122000001)(38070700005)(66476007)(64756008)(76116006)(66946007)(66446008)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjV0OTJobVhGbFFXc1dBMDNxN1lsOXpVRmFWQS8yMVVCa0VNdTY2RFhHd1BE?=
 =?utf-8?B?UDFqTmJUMUNwRHZwNHZCd1dtbkNPQ0dlVXJlcnVwblUzU1AzcUpSVGFiTzZ4?=
 =?utf-8?B?TVBaS1NGMGZJSENZTVhyU3ZFaktrOTZpNVIwVDdzR3FTcFhsSm40MFE4eSs4?=
 =?utf-8?B?dFVDd2ViekJUTzQzOTJOMGdBazZDNDF0aHNXUnFQWUh5Z1ZaWVM0Z3RFeldF?=
 =?utf-8?B?WU5ROVNkSStJM0VmWmZET05GRi9GeUVJMysxZmc2RUdiL216Y0xkODUraXpU?=
 =?utf-8?B?ZlFnWjRLendLdjBWaTVhV0Z0dDV4VjlFR1dYOVZNZnNGVGFzT3BMdndWYjBl?=
 =?utf-8?B?cGp5ZjhTU1Jhd1pjL29ldFlyV2ZBdTk3UUE3SnZpY1BHamtmcS95TjFwaG00?=
 =?utf-8?B?S1JOZFdVUlpFQTl6czdVWi9mVnRNaHQvUVA3ckpDR1F4a1BRRlZveU5rOHZD?=
 =?utf-8?B?SjlhZDVlOUNKV1AyZnRKdExPSzZOZTBBbE9WRVp2d2ozc3FNbUNvYW9XZnRL?=
 =?utf-8?B?VldzYVBLa251UnFweEpRR2x4KzNscVhFTnQrMVFMLzdHekx5QVI2U1VUQVA3?=
 =?utf-8?B?Y01GOXNaRWhsbE95bUZydmFGSysyMitaT0pEUWNNSmVic1NlcmZ0TkorcVlX?=
 =?utf-8?B?aUFndlpKVW8vdlFYYUYwMGF0Y29FNVpJZkxGdStBUUlKT1NlSGpHUzZ2QWQy?=
 =?utf-8?B?NkF5VlNHNGd3QjRTYUZpUm16cSs5TmNtQjRYdW1aN2o4UWxhWlJ1UVUvbVpX?=
 =?utf-8?B?RGFqd29PTTBMK00wL283L2VvOTZmUXZNV2dmTUgzbXUzTFFvVUtrV0hXNlFa?=
 =?utf-8?B?SWRxRzFHb0JySDNMaXdNeWtIc1VqbGVRSzdObmtldjVZQkw5eXp5K0w0UHQz?=
 =?utf-8?B?ZER3MjZjQTJ3UCtoOGNsQWJjL0l4SGppTU82YmNmNDVLaDlla2xweDV1UTdU?=
 =?utf-8?B?Ymc3dk5Dc1dsZzJXd1pvRUd5TmF6TFVMQTRrQWxHTnR6MlJEc3g4K3VFRXNw?=
 =?utf-8?B?Wlk4M0prZU1OMFFmcVFsaUFoNTV0a1BvSzJHY0NPQmpWTWFhQlNIamRKZGVn?=
 =?utf-8?B?TlBLWWYzdTR2YjhGaEI2YmJvNHF5UFVIRHhKUGxzbWNNcDRzdjdQSS9OUGtD?=
 =?utf-8?B?dEdWeER4VzN3L1U4NklEa2t0ekFRTTBxSEhpVUNoeUpUVWdnNDBWZUNGNlYw?=
 =?utf-8?B?d0kvWWtYbWoxTlJPTFh0K0lDR2FiUHZiVmZFTE1PcSt3cUtUWi9FWjZrNVd6?=
 =?utf-8?B?T3NDc25vTHR0YkpWWFBFWGlWV1oxVmlydUswY01GbTNkZi9lZTdxd3dqNnBk?=
 =?utf-8?B?WjJMeUkzUG5rTVN1ckFuOEswM05ETHN4NlVHWVVta28vMUd5cDU3QkhXOUhn?=
 =?utf-8?B?OXM4ZHRZY29lS2RYMkREcmVvOUt4RHU0TTFyejdmckdPWWZEV0E0SUpFSWNm?=
 =?utf-8?B?SFlQYWhDYlNpdm45c25tMExLVXdSYVBqRzRYbk1IcDNqNSt2VDZKNEZWOUxq?=
 =?utf-8?B?ZjIxeE53cGhpSngzNi80c3Y0bGNscm1ZZ0U1RUxoUFBHU1ZlVHo5RGc4bWZv?=
 =?utf-8?B?NUE2aEFBVHRvK2VrT1B0WVBEbm9SUUFBOGVncUU1QlZBelhhc2lpelRIRzlT?=
 =?utf-8?B?aDBWRlhqSUJ1bWRCWDFqaXV1TEpkS1RGZHZ3aVNBR1dqNWJjWGZnSXNlVmlz?=
 =?utf-8?B?T1lrK3J4ZGpsanpPbzFPN2xSVW0xbEJBa0lNRjlSVTIyam1VRDc5aXB5OXdW?=
 =?utf-8?B?KzV4RjlCeUFjNEZ6SVdocjBJYUxMWXRLc2FCS0pRMGZydTJWZ2JRWEdyNW1a?=
 =?utf-8?B?UnJVMmlGNE8wYng2T3pHajFDbjF1VUt5MTF3YkszZWJWam5aZmNpVWc4eHlw?=
 =?utf-8?B?VllibFRjT0ZXZXpiYjFNcjVvU2JEaVlBbU5tNXY0UExSTTBIeWVYeCszUFB6?=
 =?utf-8?B?RktDUHZLaWZyM2VscjJKUmlRL0luMzc0WGhtbVlBMnpXQWU4UVNSbkhyTlc1?=
 =?utf-8?B?bVNoODhGL0ZKY0FsOUh3K3NabHFiWEpHcTRyV0FHQmtoNEl3SlExbGMxWlJT?=
 =?utf-8?B?a3FtMXoyNXhjVmhBRUVYNUZaT0JRQTJzeUlLL2pSbWxoRkFXblJVQmhReGwr?=
 =?utf-8?B?YnlPM2ErSW84L0JJYU9TbUpNdFpMaUFkUXVCNVVVN0FjL2pmY3gvUjVDOTFX?=
 =?utf-8?B?Z1ZQc3VsWCswdXhnaGI5VnJhWlc5Ukl6Z3EvWmI2SVFqb3FGclRCUHRzRzlp?=
 =?utf-8?B?TkZmNWxhbU8rRkgyZjEvcDVDejhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4917268-264e-4af6-a2d6-08d9c451c80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 07:16:17.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doiEse+O5sbMqqrv1Ey/d3W+yTR1hbBy1n44vPN1BHuttGEBk7Q3fubaN+XknqE/d6AE40z7y+N2Tnfsz7kUVdVTppLFzi4szOgKcqFYpS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7135
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQWRyaWFuLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNClBsZWFzZSBmaW5kIHRoZSBp
bmxpbmUgY29tbWVudHMuDQoNClRoYW5rcywNClNhamlkYQ0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+IA0K
U2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxNSwgMjAyMSA3OjMzIFBNDQpUbzogU2FqaWRhIEJo
YW51IChUZW1wKSAoUVVJQykgPHF1aWNfY19zYmhhbnVAcXVpY2luYy5jb20+OyByaXRlc2hoQGNv
ZGVhdXJvcmEub3JnOyBBc3V0b3NoIERhcyAoYXNkKSA8YXN1dG9zaGRAcXVpY2luYy5jb20+OyB1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBhZ3Jvc3NAa2VybmVsLm9yZzsgYmpvcm4uYW5kZXJzc29u
QGxpbmFyby5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1tc21Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpDYzogc3R1bW1hbGFA
Y29kZWF1cm9yYS5vcmc7IHZiYWRpZ2FuQGNvZGVhdXJvcmEub3JnOyBSYW0gUHJha2FzaCBHdXB0
YSAoUVVJQykgPHF1aWNfcmFtcHJha2FAcXVpY2luYy5jb20+OyBQcmFkZWVwIFByYWdhbGxhcGF0
aSAoUVVJQykgPHF1aWNfcHJhZ2FsbGFAcXVpY2luYy5jb20+OyBzYXJ0Z2FyZ0Bjb2RlYXVyb3Jh
Lm9yZzsgbml0aXJhd2FAY29kZWF1cm9yYS5vcmc7IHNheWFsaWxAY29kZWF1cm9yYS5vcmcNClN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIG1tYzogZGVidWdmczogYWRkIGVycm9yIHN0YXRpc3RpY3MN
Cg0KT24gMTQvMTIvMjAyMSAxNjo0MSwgU2hhaWsgU2FqaWRhIEJoYW51IHdyb3RlOg0KPiBBZGQg
ZGVidWdmcyBlbnRyeSB0byBxdWVyeSBlTU1DIGFuZCBTRCBjYXJkIGVycm9ycyBzdGF0aXN0aWNz
Lg0KPiBUaGlzIGZlYXR1cmUgaXMgdXNlZnVsIGZvciBkZWJ1ZyBhbmQgdGVzdGluZw0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU2hhaWsgU2FqaWRhIEJoYW51IDxxdWljX2Nfc2JoYW51QHF1aWNpbmMu
Y29tPg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgc2luY2UgVjE6DQo+IAktUmVtb3ZlZCBzeXNmcyBl
bnRyeSBmb3IgZU1NQyBhbmQgU0QgY2FyZCBlcnJvciBzdGF0aXN0aWNzIGFuZCBhZGRlZA0KPiAJ
IGRlYnVnZnMgZW50cnkgYXMgc3VnZ2VzdGVkIGJ5IEFkcmlhbiBIdW50ZXIgYW5kIFVsZiBIYW5z
c29uLg0KDQpUaGFua3MgZm9yIGRvaW5nIHRoaXMuDQoNCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9j
b3JlL2RlYnVnZnMuYyB8IDEwNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIGRyaXZlcnMvbW1jL2NvcmUvcXVldWUuYyAgIHwgICAyICsNCj4gIGRyaXZl
cnMvbW1jL2hvc3Qvc2RoY2kuYyAgIHwgIDUzICsrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICBp
bmNsdWRlL2xpbnV4L21tYy9ob3N0LmggICB8ICAzNyArKysrKysrKysrKysrKysrDQo+ICA0IGZp
bGVzIGNoYW5nZWQsIDE4NiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2RlYnVnZnMuYyBiL2RyaXZlcnMvbW1jL2NvcmUv
ZGVidWdmcy5jIA0KPiBpbmRleCAzZmRiYzgwLi40MDIxMGMzNCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2Zz
LmMNCj4gQEAgLTIyMyw2ICsyMjMsMTA3IEBAIHN0YXRpYyBpbnQgbW1jX2Nsb2NrX29wdF9zZXQo
dm9pZCAqZGF0YSwgdTY0IA0KPiB2YWwpICBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUobW1jX2Ns
b2NrX2ZvcHMsIG1tY19jbG9ja19vcHRfZ2V0LCBtbWNfY2xvY2tfb3B0X3NldCwNCj4gIAkiJWxs
dVxuIik7DQo+ICANCj4gK3N0YXRpYyBpbnQgbW1jX2Vycl9zdGF0ZV9nZXQodm9pZCAqZGF0YSwg
dTY0ICp2YWwpIHsNCj4gKwlzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QgPSBkYXRhOw0KPiArDQo+ICsJ
aWYgKCFob3N0KQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCSp2YWwgPSBob3N0LT5l
cnJfc3RhdGUgPyAxIDogMDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0
aWMgaW50IG1tY19lcnJfc3RhdGVfY2xlYXIodm9pZCAqZGF0YSwgdTY0IHZhbCkgew0KPiArCXN0
cnVjdCBtbWNfaG9zdCAqaG9zdCA9IGRhdGE7DQo+ICsNCj4gKwlpZiAoIWhvc3QpDQo+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiArDQo+ICsJaG9zdC0+ZXJyX3N0YXRlID0gZmFsc2U7DQoNCklzIHRo
ZXJlIG11Y2ggcmVhc29uIHRvIGRpc2FibGUgZXJyIHN0YXRzIGZyb20gdXNlcnNwYWNlPw0KDQo+
Pj4+PiBZZXMgLCB3aGlsZSBkZWJ1Z2dpbmcgd2UgY2FuIGdvIGFuZCBjaGVjayBlcnJfc3RhdGUg
LCBJdCBpcyBmYWxzZSBtZWFucyBubyBlcnJvcnMgaGFwcGVuZWQgaW4gZHJpdmVyIGxldmVsIGFu
ZCB0cnVlIG1lYW5zIGVycm9ycyBoYXBwZW5lZCBpbiBkcml2ZXIgbGV2ZWwgYW5kIHRoZW4gd2Ug
Y2FuIGdvIGFuZCBjaGVjayBlcnJfc3RhdHNbXSB0byBrbm93IG1vcmUgb24gZXJyb3IgZGV0YWls
cyBsaWtlIGRhdGEgQ1JDICwgY29tbWFuZCBDUkMgZXRjLg0KDQo+ICsNCj4gKwlyZXR1cm4gMDsN
Cj4gK30NCj4gKw0KPiArREVGSU5FX1NJTVBMRV9BVFRSSUJVVEUobW1jX2Vycl9zdGF0ZSwgbW1j
X2Vycl9zdGF0ZV9nZXQsDQo+ICsJCW1tY19lcnJfc3RhdGVfY2xlYXIsICIlbGx1XG4iKTsNCj4g
Kw0KPiArc3RhdGljIGludCBtbWNfZXJyX3N0YXRzX3Nob3coc3RydWN0IHNlcV9maWxlICpmaWxl
LCB2b2lkICpkYXRhKSB7DQo+ICsJc3RydWN0IG1tY19ob3N0ICpob3N0ID0gKHN0cnVjdCBtbWNf
aG9zdCAqKWZpbGUtPnByaXZhdGU7DQo+ICsNCj4gKwlpZiAoIWhvc3QpDQo+ICsJCXJldHVybiAt
RUlOVkFMOw0KDQpJIHdhcyB0aGlua2luZyB3ZSBuZWVkZWQgYSB3YXkgdG8gZGV0ZXJtaW5lIHdo
ZXRoZXIgc3RhdHMgd2VyZSBiZWluZyBjb2xsZWN0ZWQgYmVjYXVzZSBub3QgYWxsIGRyaXZlcnMg
d291bGQgc3VwcG9ydCBpdCBhdCBsZWFzdCBpbml0aWFsbHkgZS5nLg0KDQoJaWYgKCFob3N0LT5l
cnJfc3RhdHNfZW5hYmxlZCkgew0KCQlzZXFfcHJpbnRmKGZpbGUsICJOb3Qgc3VwcG9ydGVkIGJ5
IGRyaXZlclxuIik7DQoJCXJldHVybiAwOw0KCX0NCg0KPj4+Pj4+PllvdSBtZWFuIGRlY2xhcmUg
YW5vdGhlciB2YXJpYWJsZSAoZXJyX3N0YXRzX2VuYWJsZWQpIGFuZCBlbmFibGUgaXQgaW4gcHJv
YmU/DQoNCj4gKw0KPiArCXNlcV9wcmludGYoZmlsZSwgIiMgQ29tbWFuZCBUaW1lb3V0IE9jY3Vy
cmVkOlx0ICVkXG4iLA0KPiArCQkgICBob3N0LT5lcnJfc3RhdHNbTU1DX0VSUl9DTURfVElNRU9V
VF0pOw0KDQpNYXliZSBwdXQgdGhlIGRlc2NyaXB0aW9ucyBpbiBhbiBhcnJheSBhbmQgaXRlcmF0
ZSBlLmcuDQoNCgljb25zdCBjaGFyICpkZXNjW01NQ19FUlJfTUFYXSA9IHsNCgkJW01NQ19FUlJf
Q01EX1RJTUVPVVRdID0gIkNvbW1hbmQgVGltZW91dCBPY2N1cnJlZCIsDQoJCWV0Yw0KCX07DQoJ
aW50IGk7DQoNCglpZiAoIWhvc3QpDQoJCXJldHVybiAtRUlOVkFMOw0KDQoJZm9yIChpID0gMDsg
aSA8IE1NQ19FUlJfTUFYOyBpKyspIHsNCgkJaWYgKGRlc2NbaV0pDQoJCQlzZXFfcHJpbnRmKGZp
bGUsICIjICVzOlx0ICVkXG4iLA0KCQkJCSAgIGRlc2NbMV0sIGhvc3QtPmVycl9zdGF0c1tpXSk7
DQoJfQ0KDQo+Pj4+Pj4+IFN1cmUgDQoNCj4gKw0KPiArCXNlcV9wcmludGYoZmlsZSwgIiMgQ29t
bWFuZCBDUkMgRXJyb3JzIE9jY3VycmVkOlx0ICVkXG4iLA0KPiArCQkgICBob3N0LT5lcnJfc3Rh
dHNbTU1DX0VSUl9DTURfQ1JDXSk7DQo+ICsNCj4gKwlzZXFfcHJpbnRmKGZpbGUsICIjIERhdGEg
VGltZW91dCBPY2N1cnJlZDpcdCAlZFxuIiwNCj4gKwkJICAgaG9zdC0+ZXJyX3N0YXRzW01NQ19F
UlJfREFUX1RJTUVPVVRdKTsNCj4gKw0KPiArCXNlcV9wcmludGYoZmlsZSwgIiMgRGF0YSBDUkMg
RXJyb3JzIE9jY3VycmVkOlx0ICVkXG4iLA0KPiArCQkgICBob3N0LT5lcnJfc3RhdHNbTU1DX0VS
Ul9EQVRfQ1JDXSk7DQo+ICsNCj4gKwlzZXFfcHJpbnRmKGZpbGUsICIjIEF1dG8tQ21kIEVycm9y
IE9jY3VycmVkOlx0ICVkXG4iLA0KPiArCQkgICBob3N0LT5lcnJfc3RhdHNbTU1DX0VSUl9BRE1B
XSk7DQo+ICsNCj4gKwlzZXFfcHJpbnRmKGZpbGUsICIjIEFETUEgRXJyb3IgT2NjdXJyZWQ6XHQg
JWRcbiIsDQo+ICsJCSAgIGhvc3QtPmVycl9zdGF0c1tNTUNfRVJSX0FETUFdKTsNCj4gKw0KPiAr
CXNlcV9wcmludGYoZmlsZSwgIiMgVHVuaW5nIEVycm9yIE9jY3VycmVkOlx0ICVkXG4iLA0KPiAr
CQkgICBob3N0LT5lcnJfc3RhdHNbTU1DX0VSUl9UVU5JTkddKTsNCj4gKw0KPiArCXNlcV9wcmlu
dGYoZmlsZSwgIiMgQ01EUSBSRUQgRXJyb3JzOlx0XHQgJWRcbiIsDQo+ICsJCSAgIGhvc3QtPmVy
cl9zdGF0c1tNTUNfRVJSX0NNRFFfUkVEXSk7DQo+ICsNCj4gKwlzZXFfcHJpbnRmKGZpbGUsICIj
IENNRFEgR0NFIEVycm9yczpcdFx0ICVkXG4iLA0KPiArCQkgICBob3N0LT5lcnJfc3RhdHNbTU1D
X0VSUl9DTURRX0dDRV0pOw0KPiArDQo+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBDTURRIElDQ0Ug
RXJyb3JzOlx0XHQgJWRcbiIsDQo+ICsJCSAgIGhvc3QtPmVycl9zdGF0c1tNTUNfRVJSX0NNRFFf
SUNDRV0pOw0KPiArDQo+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBSZXF1ZXN0IFRpbWVkb3V0Olx0
ICVkXG4iLA0KPiArCQkgICBob3N0LT5lcnJfc3RhdHNbTU1DX0VSUl9SRVFfVElNRU9VVF0pOw0K
PiArDQo+ICsJc2VxX3ByaW50ZihmaWxlLCAiIyBDTURRIFJlcXVlc3QgVGltZWRvdXQ6XHQgJWRc
biIsDQo+ICsJCSAgIGhvc3QtPmVycl9zdGF0c1tNTUNfRVJSX0NNRFFfUkVRX1RJTUVPVVRdKTsN
Cj4gKw0KPiArCXNlcV9wcmludGYoZmlsZSwgIiMgSUNFIENvbmZpZyBFcnJvcnM6XHRcdCAlZFxu
IiwNCj4gKwkJICAgaG9zdC0+ZXJyX3N0YXRzW01NQ19FUlJfSUNFX0NGR10pOw0KPiArDQo+ICsJ
cmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbW1jX2Vycl9zdGF0c19vcGVuKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKSANCj4gK3sNCj4gKwlyZXR1cm4g
c2luZ2xlX29wZW4oZmlsZSwgbW1jX2Vycl9zdGF0c19zaG93LCBpbm9kZS0+aV9wcml2YXRlKTsg
fQ0KPiArDQo+ICtzdGF0aWMgc3NpemVfdCBtbWNfZXJyX3N0YXRzX3dyaXRlKHN0cnVjdCBmaWxl
ICpmaWxwLCBjb25zdCBjaGFyIF9fdXNlciAqdWJ1ZiwNCj4gKwkJCQkgICBzaXplX3QgY250LCBs
b2ZmX3QgKnBwb3MpDQo+ICt7DQo+ICsJc3RydWN0IG1tY19ob3N0ICpob3N0ID0gZmlscC0+Zl9t
YXBwaW5nLT5ob3N0LT5pX3ByaXZhdGU7DQo+ICsNCj4gKwlpZiAoIWhvc3QpDQo+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiArDQo+ICsJcHJfZGVidWcoIiVzOiBSZXNldHRpbmcgTU1DIGVycm9yIHN0
YXRpc3RpY3NcbiIsIF9fZnVuY19fKTsNCj4gKwltZW1zZXQoaG9zdC0+ZXJyX3N0YXRzLCAwLCBz
aXplb2YoaG9zdC0+ZXJyX3N0YXRzKSk7DQo+ICsNCj4gKwlyZXR1cm4gY250Ow0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBtbWNfZXJyX3N0YXRzX2Zv
cHMgPSB7DQo+ICsJLm9wZW4JPSBtbWNfZXJyX3N0YXRzX29wZW4sDQo+ICsJLnJlYWQJPSBzZXFf
cmVhZCwNCj4gKwkud3JpdGUJPSBtbWNfZXJyX3N0YXRzX3dyaXRlLA0KPiArfTsNCj4gKw0KPiAg
dm9pZCBtbWNfYWRkX2hvc3RfZGVidWdmcyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpICB7DQo+ICAJ
c3RydWN0IGRlbnRyeSAqcm9vdDsNCj4gQEAgLTIzNiw2ICszMzcsMTEgQEAgdm9pZCBtbWNfYWRk
X2hvc3RfZGVidWdmcyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+ICAJZGVidWdmc19jcmVhdGVf
ZmlsZV91bnNhZmUoImNsb2NrIiwgU19JUlVTUiB8IFNfSVdVU1IsIHJvb3QsIGhvc3QsDQo+ICAJ
CQkJICAgJm1tY19jbG9ja19mb3BzKTsNCj4gIA0KPiArCWRlYnVnZnNfY3JlYXRlX2ZpbGUoImVy
cl9zdGF0ZSIsIDA2MDAsIHJvb3QsIGhvc3QsDQo+ICsJCSZtbWNfZXJyX3N0YXRlKTsNCj4gKwlk
ZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJlcnJfc3RhdHMiLCAwNjAwLCByb290LCBob3N0LA0KPiArCQkm
bW1jX2Vycl9zdGF0c19mb3BzKTsNCj4gKw0KPiAgI2lmZGVmIENPTkZJR19GQUlMX01NQ19SRVFV
RVNUDQo+ICAJaWYgKGZhaWxfcmVxdWVzdCkNCj4gIAkJc2V0dXBfZmF1bHRfYXR0cigmZmFpbF9k
ZWZhdWx0X2F0dHIsIGZhaWxfcmVxdWVzdCk7IGRpZmYgLS1naXQgDQo+IGEvZHJpdmVycy9tbWMv
Y29yZS9xdWV1ZS5jIGIvZHJpdmVycy9tbWMvY29yZS9xdWV1ZS5jIGluZGV4IA0KPiBiMTVjMDM0
Li41MjQzOTI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3F1ZXVlLmMNCj4gKysr
IGIvZHJpdmVycy9tbWMvY29yZS9xdWV1ZS5jDQo+IEBAIC0xMDAsNiArMTAwLDggQEAgc3RhdGlj
IGVudW0gYmxrX2VoX3RpbWVyX3JldHVybiBtbWNfY3FlX3RpbWVkX291dChzdHJ1Y3QgcmVxdWVz
dCAqcmVxKQ0KPiAgCWVudW0gbW1jX2lzc3VlX3R5cGUgaXNzdWVfdHlwZSA9IG1tY19pc3N1ZV90
eXBlKG1xLCByZXEpOw0KPiAgCWJvb2wgcmVjb3ZlcnlfbmVlZGVkID0gZmFsc2U7DQo+ICANCj4g
KwltbWNfZGVidWdmc19lcnJfc3RhdHNfaW5jKGhvc3QsIE1NQ19FUlJfQ01EUV9SRVFfVElNRU9V
VCk7DQo+ICsNCj4gIAlzd2l0Y2ggKGlzc3VlX3R5cGUpIHsNCj4gIAljYXNlIE1NQ19JU1NVRV9B
U1lOQzoNCj4gIAljYXNlIE1NQ19JU1NVRV9EQ01EOg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jDQoNCkkgdGhpbmsgdGhl
IGNvcmUgY2hhbmdlcyBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaCBmcm9tIHNkaGNpLg0KSSB3
b3VsZCBwcm9iYWJseSBzcGxpdCBpbnRvIDQ6DQoJbW1jIGNvcmUNCgltbWMgYmxvY2sgZHJpdmVy
DQoJY3FoY2kgZHJpdmVyDQoJc2RoY2kgZHJpdmVyDQoNCj4+Pj4gU3VyZQ0KDQo+IGluZGV4IDA3
YzZkYTEuLmQ3NDIwNTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0K
PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4gQEAgLTExMyw2ICsxMTMsNyBAQCB2
b2lkIHNkaGNpX2R1bXByZWdzKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0KPiAgCWlmIChob3N0
LT5vcHMtPmR1bXBfdmVuZG9yX3JlZ3MpDQo+ICAJCWhvc3QtPm9wcy0+ZHVtcF92ZW5kb3JfcmVn
cyhob3N0KTsNCj4gIA0KPiArCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19lbmFibGUoaG9zdC0+bW1j
KTsNCg0KV2h5IGhlcmUgYW5kIG5vdCBpbiBlLmcuIF9fc2RoY2lfYWRkX2hvc3QoKSA/DQoNCj4+
Pj4gSWYgYW55IGVycm9ycyBoYXBwZW5lZCAgaW4gZHJpdmVyIGxldmVsIHRoZW4gd2Ugd2lsbCBj
YWxsIHNkaGNpX2R1bXByZWdzKCkgcmlnaHQoIGVycl9zdGF0ZSB0cnVlIG1lYW5zIHNvbWUgZXJy
b3JzIGhhcHBlbmVkIGluIGRyaXZlciBsZXZlbCApLiAgU28gaXQgaXMgYmV0dGVyIHRvIGNhbGwg
bW1jX2RlYnVnZnNfZXJyX3N0YXRzX2VuYWJsZSgpIGhlcmUuDQoNCj4gIAlTREhDSV9EVU1QKCI9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PVxuIik7DQo+ICB9DQo+
ICBFWFBPUlRfU1lNQk9MX0dQTChzZGhjaV9kdW1wcmVncyk7DQo+IEBAIC0zMTU5LDYgKzMxNjAs
NyBAQCBzdGF0aWMgdm9pZCBzZGhjaV90aW1lb3V0X3RpbWVyKHN0cnVjdCB0aW1lcl9saXN0ICp0
KQ0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZob3N0LT5sb2NrLCBmbGFncyk7DQo+ICANCj4gIAlp
ZiAoaG9zdC0+Y21kICYmICFzZGhjaV9kYXRhX2xpbmVfY21kKGhvc3QtPmNtZCkpIHsNCj4gKwkJ
bW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhob3N0LT5tbWMsIE1NQ19FUlJfUkVRX1RJTUVPVVQp
Ow0KPiAgCQlwcl9lcnIoIiVzOiBUaW1lb3V0IHdhaXRpbmcgZm9yIGhhcmR3YXJlIGNtZCBpbnRl
cnJ1cHQuXG4iLA0KPiAgCQkgICAgICAgbW1jX2hvc3RuYW1lKGhvc3QtPm1tYykpOw0KPiAgCQlz
ZGhjaV9kdW1wcmVncyhob3N0KTsNCj4gQEAgLTMxODEsNiArMzE4Myw3IEBAIHN0YXRpYyB2b2lk
IHNkaGNpX3RpbWVvdXRfZGF0YV90aW1lcihzdHJ1Y3QgDQo+IHRpbWVyX2xpc3QgKnQpDQo+ICAN
Cj4gIAlpZiAoaG9zdC0+ZGF0YSB8fCBob3N0LT5kYXRhX2NtZCB8fA0KPiAgCSAgICAoaG9zdC0+
Y21kICYmIHNkaGNpX2RhdGFfbGluZV9jbWQoaG9zdC0+Y21kKSkpIHsNCj4gKwkJbW1jX2RlYnVn
ZnNfZXJyX3N0YXRzX2luYyhob3N0LT5tbWMsIE1NQ19FUlJfUkVRX1RJTUVPVVQpOw0KPiAgCQlw
cl9lcnIoIiVzOiBUaW1lb3V0IHdhaXRpbmcgZm9yIGhhcmR3YXJlIGludGVycnVwdC5cbiIsDQo+
ICAJCSAgICAgICBtbWNfaG9zdG5hbWUoaG9zdC0+bW1jKSk7DQo+ICAJCXNkaGNpX2R1bXByZWdz
KGhvc3QpOw0KPiBAQCAtMzI0MCwxMSArMzI0MywxNSBAQCBzdGF0aWMgdm9pZCBzZGhjaV9jbWRf
aXJxKHN0cnVjdCBzZGhjaV9ob3N0IA0KPiAqaG9zdCwgdTMyIGludG1hc2ssIHUzMiAqaW50bWFz
a19wKQ0KPiAgDQo+ICAJaWYgKGludG1hc2sgJiAoU0RIQ0lfSU5UX1RJTUVPVVQgfCBTREhDSV9J
TlRfQ1JDIHwNCj4gIAkJICAgICAgIFNESENJX0lOVF9FTkRfQklUIHwgU0RIQ0lfSU5UX0lOREVY
KSkgew0KPiAtCQlpZiAoaW50bWFzayAmIFNESENJX0lOVF9USU1FT1VUKQ0KPiArCQlpZiAoaW50
bWFzayAmIFNESENJX0lOVF9USU1FT1VUKSB7DQo+ICAJCQlob3N0LT5jbWQtPmVycm9yID0gLUVU
SU1FRE9VVDsNCj4gLQkJZWxzZQ0KPiArCQkJbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhob3N0
LT5tbWMsIE1NQ19FUlJfQ01EX1RJTUVPVVQpOw0KPiArCQl9IGVsc2Ugew0KPiAgCQkJaG9zdC0+
Y21kLT5lcnJvciA9IC1FSUxTRVE7DQo+IC0NCj4gKwkJCWlmIChob3N0LT5jbWQtPm9wY29kZSAh
PSBNTUNfU0VORF9UVU5JTkdfQkxPQ0sgfHwNCj4gKwkJCQkJaG9zdC0+Y21kLT5vcGNvZGUgIT0g
TU1DX1NFTkRfVFVOSU5HX0JMT0NLX0hTMjAwKQ0KPiArCQkJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0
c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX0NNRF9DUkMpOw0KPiArCQl9DQo+ICAJCS8qIFRyZWF0
IGRhdGEgY29tbWFuZCBDUkMgZXJyb3IgdGhlIHNhbWUgYXMgZGF0YSBDUkMgZXJyb3IgKi8NCj4g
IAkJaWYgKGhvc3QtPmNtZC0+ZGF0YSAmJg0KPiAgCQkgICAgKGludG1hc2sgJiAoU0RIQ0lfSU5U
X0NSQyB8IFNESENJX0lOVF9USU1FT1VUKSkgPT0gQEAgLTMyNjYsNiANCj4gKzMyNzMsNyBAQCBz
dGF0aWMgdm9pZCBzZGhjaV9jbWRfaXJxKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1MzIgaW50
bWFzaywgdTMyICppbnRtYXNrX3ApDQo+ICAJCQkgIC1FVElNRURPVVQgOg0KPiAgCQkJICAtRUlM
U0VROw0KPiAgDQo+ICsJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoaG9zdC0+bW1jLCBNTUNf
RVJSX0FVVE9fQ01EKTsNCj4gIAkJaWYgKHNkaGNpX2F1dG9fY21kMjMoaG9zdCwgbXJxKSkgew0K
PiAgCQkJbXJxLT5zYmMtPmVycm9yID0gZXJyOw0KPiAgCQkJX19zZGhjaV9maW5pc2hfbXJxKGhv
c3QsIG1ycSk7DQo+IEBAIC0zMzQyLDYgKzMzNTAsNyBAQCBzdGF0aWMgdm9pZCBzZGhjaV9kYXRh
X2lycShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTMyIGludG1hc2spDQo+ICAJCQlpZiAoaW50
bWFzayAmIFNESENJX0lOVF9EQVRBX1RJTUVPVVQpIHsNCj4gIAkJCQlob3N0LT5kYXRhX2NtZCA9
IE5VTEw7DQo+ICAJCQkJZGF0YV9jbWQtPmVycm9yID0gLUVUSU1FRE9VVDsNCj4gKwkJCQltbWNf
ZGVidWdmc19lcnJfc3RhdHNfaW5jKGhvc3QtPm1tYywgTU1DX0VSUl9DTURfVElNRU9VVCk7DQo+
ICAJCQkJX19zZGhjaV9maW5pc2hfbXJxKGhvc3QsIGRhdGFfY21kLT5tcnEpOw0KPiAgCQkJCXJl
dHVybjsNCj4gIAkJCX0NCj4gQEAgLTMzNzUsMTggKzMzODQsMjUgQEAgc3RhdGljIHZvaWQgc2Ro
Y2lfZGF0YV9pcnEoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHUzMiBpbnRtYXNrKQ0KPiAgCQly
ZXR1cm47DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKGludG1hc2sgJiBTREhDSV9JTlRfREFUQV9USU1F
T1VUKQ0KPiArCWlmIChpbnRtYXNrICYgU0RIQ0lfSU5UX0RBVEFfVElNRU9VVCkgew0KPiAgCQlo
b3N0LT5kYXRhLT5lcnJvciA9IC1FVElNRURPVVQ7DQo+ICsJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0
c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX0RBVF9USU1FT1VUKTsNCj4gKwl9DQo+ICAJZWxzZSBp
ZiAoaW50bWFzayAmIFNESENJX0lOVF9EQVRBX0VORF9CSVQpDQo+ICAJCWhvc3QtPmRhdGEtPmVy
cm9yID0gLUVJTFNFUTsNCj4gIAllbHNlIGlmICgoaW50bWFzayAmIFNESENJX0lOVF9EQVRBX0NS
QykgJiYNCj4gIAkJU0RIQ0lfR0VUX0NNRChzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9DT01NQU5E
KSkNCj4gLQkJCSE9IE1NQ19CVVNfVEVTVF9SKQ0KPiArCQkJIT0gTU1DX0JVU19URVNUX1IpIHsN
Cj4gIAkJaG9zdC0+ZGF0YS0+ZXJyb3IgPSAtRUlMU0VROw0KPiArCQlpZiAoaG9zdC0+Y21kLT5v
cGNvZGUgIT0gTU1DX1NFTkRfVFVOSU5HX0JMT0NLIHx8DQo+ICsJCQkJaG9zdC0+Y21kLT5vcGNv
ZGUgIT0gTU1DX1NFTkRfVFVOSU5HX0JMT0NLX0hTMjAwKQ0KPiArCQkJbW1jX2RlYnVnZnNfZXJy
X3N0YXRzX2luYyhob3N0LT5tbWMsIE1NQ19FUlJfREFUX0NSQyk7DQo+ICsJfQ0KPiAgCWVsc2Ug
aWYgKGludG1hc2sgJiBTREhDSV9JTlRfQURNQV9FUlJPUikgew0KPiAgCQlwcl9lcnIoIiVzOiBB
RE1BIGVycm9yOiAweCUwOHhcbiIsIG1tY19ob3N0bmFtZShob3N0LT5tbWMpLA0KPiAgCQkgICAg
ICAgaW50bWFzayk7DQo+ICAJCXNkaGNpX2FkbWFfc2hvd19lcnJvcihob3N0KTsNCj4gKwkJbW1j
X2RlYnVnZnNfZXJyX3N0YXRzX2luYyhob3N0LT5tbWMsIE1NQ19FUlJfQURNQSk7DQo+ICAJCWhv
c3QtPmRhdGEtPmVycm9yID0gLUVJTzsNCj4gIAkJaWYgKGhvc3QtPm9wcy0+YWRtYV93b3JrYXJv
dW5kKQ0KPiAgCQkJaG9zdC0+b3BzLT5hZG1hX3dvcmthcm91bmQoaG9zdCwgaW50bWFzayk7IEBA
IC0zOTA1LDIwICszOTIxLDMzIEBAIA0KPiBib29sIHNkaGNpX2NxZV9pcnEoc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QsIHUzMiBpbnRtYXNrLCBpbnQgKmNtZF9lcnJvciwNCj4gIAlpZiAoIWhvc3Qt
PmNxZV9vbikNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+IC0JaWYgKGludG1hc2sgJiAoU0RI
Q0lfSU5UX0lOREVYIHwgU0RIQ0lfSU5UX0VORF9CSVQgfCBTREhDSV9JTlRfQ1JDKSkNCj4gKwlp
ZiAoaW50bWFzayAmIChTREhDSV9JTlRfSU5ERVggfCBTREhDSV9JTlRfRU5EX0JJVCB8IFNESENJ
X0lOVF9DUkMpKSANCj4gK3sNCj4gIAkJKmNtZF9lcnJvciA9IC1FSUxTRVE7DQo+IC0JZWxzZSBp
ZiAoaW50bWFzayAmIFNESENJX0lOVF9USU1FT1VUKQ0KPiArCQlpZiAoaW50bWFzayAmIFNESENJ
X0lOVF9DUkMpIHsNCj4gKwkJCWlmIChob3N0LT5jbWQtPm9wY29kZSAhPSBNTUNfU0VORF9UVU5J
TkdfQkxPQ0sgfHwNCj4gKwkJCQkJaG9zdC0+Y21kLT5vcGNvZGUgIT0gTU1DX1NFTkRfVFVOSU5H
X0JMT0NLX0hTMjAwKQ0KPiArCQkJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoaG9zdC0+bW1j
LCBNTUNfRVJSX0NNRF9DUkMpOw0KPiArCQl9DQo+ICsJfSBlbHNlIGlmIChpbnRtYXNrICYgU0RI
Q0lfSU5UX1RJTUVPVVQpIHsNCj4gIAkJKmNtZF9lcnJvciA9IC1FVElNRURPVVQ7DQo+IC0JZWxz
ZQ0KPiArCQltbWNfZGVidWdmc19lcnJfc3RhdHNfaW5jKGhvc3QtPm1tYywgTU1DX0VSUl9DTURf
VElNRU9VVCk7DQo+ICsJfSBlbHNlDQo+ICAJCSpjbWRfZXJyb3IgPSAwOw0KPiAgDQo+IC0JaWYg
KGludG1hc2sgJiAoU0RIQ0lfSU5UX0RBVEFfRU5EX0JJVCB8IFNESENJX0lOVF9EQVRBX0NSQykp
DQo+ICsJaWYgKGludG1hc2sgJiAoU0RIQ0lfSU5UX0RBVEFfRU5EX0JJVCB8IFNESENJX0lOVF9E
QVRBX0NSQykpIHsNCj4gIAkJKmRhdGFfZXJyb3IgPSAtRUlMU0VROw0KPiAtCWVsc2UgaWYgKGlu
dG1hc2sgJiBTREhDSV9JTlRfREFUQV9USU1FT1VUKQ0KPiArCQlpZiAoaW50bWFzayAmIFNESENJ
X0lOVF9EQVRBX0NSQykgew0KPiArCQkJaWYgKGhvc3QtPmNtZC0+b3Bjb2RlICE9IE1NQ19TRU5E
X1RVTklOR19CTE9DSyB8fA0KPiArCQkJCQlob3N0LT5jbWQtPm9wY29kZSAhPSBNTUNfU0VORF9U
VU5JTkdfQkxPQ0tfSFMyMDApDQo+ICsJCQkJbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhob3N0
LT5tbWMsIE1NQ19FUlJfREFUX0NSQyk7DQo+ICsJCX0NCj4gKwl9IGVsc2UgaWYgKGludG1hc2sg
JiBTREhDSV9JTlRfREFUQV9USU1FT1VUKSB7DQo+ICAJCSpkYXRhX2Vycm9yID0gLUVUSU1FRE9V
VDsNCj4gLQllbHNlIGlmIChpbnRtYXNrICYgU0RIQ0lfSU5UX0FETUFfRVJST1IpDQo+ICsJCW1t
Y19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoaG9zdC0+bW1jLCBNTUNfRVJSX0RBVF9USU1FT1VUKTsN
Cj4gKwl9IGVsc2UgaWYgKGludG1hc2sgJiBTREhDSV9JTlRfQURNQV9FUlJPUikgew0KPiAgCQkq
ZGF0YV9lcnJvciA9IC1FSU87DQo+IC0JZWxzZQ0KPiArCQltbWNfZGVidWdmc19lcnJfc3RhdHNf
aW5jKGhvc3QtPm1tYywgTU1DX0VSUl9BRE1BKTsNCj4gKwl9IGVsc2UNCj4gIAkJKmRhdGFfZXJy
b3IgPSAwOw0KPiAgDQo+ICAJLyogQ2xlYXIgc2VsZWN0ZWQgaW50ZXJydXB0cy4gKi8NCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaCBiL2luY2x1ZGUvbGludXgvbW1jL2hv
c3QuaCBpbmRleCANCj4gN2FmYjU3Yy4uYzI2M2Y4ZiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9tbWMvaG9zdC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaA0KPiBAQCAt
OTMsNiArOTMsMjMgQEAgc3RydWN0IG1tY19jbGtfcGhhc2VfbWFwIHsNCj4gIA0KPiAgc3RydWN0
IG1tY19ob3N0Ow0KPiAgDQo+ICtlbnVtIG1tY19lcnJfc3RhdCB7DQo+ICsJTU1DX0VSUl9DTURf
VElNRU9VVCwNCj4gKwlNTUNfRVJSX0NNRF9DUkMsDQo+ICsJTU1DX0VSUl9EQVRfVElNRU9VVCwN
Cj4gKwlNTUNfRVJSX0RBVF9DUkMsDQo+ICsJTU1DX0VSUl9BVVRPX0NNRCwNCj4gKwlNTUNfRVJS
X0FETUEsDQo+ICsJTU1DX0VSUl9UVU5JTkcsDQo+ICsJTU1DX0VSUl9DTURRX1JFRCwNCj4gKwlN
TUNfRVJSX0NNRFFfR0NFLA0KPiArCU1NQ19FUlJfQ01EUV9JQ0NFLA0KPiArCU1NQ19FUlJfUkVR
X1RJTUVPVVQsDQo+ICsJTU1DX0VSUl9DTURRX1JFUV9USU1FT1VULA0KPiArCU1NQ19FUlJfSUNF
X0NGRywNCj4gKwlNTUNfRVJSX01BWCwNCj4gK307DQo+ICsNCj4gIHN0cnVjdCBtbWNfaG9zdF9v
cHMgew0KPiAgCS8qDQo+ICAJICogSXQgaXMgb3B0aW9uYWwgZm9yIHRoZSBob3N0IHRvIGltcGxl
bWVudCBwcmVfcmVxIGFuZCBwb3N0X3JlcSBpbiANCj4gQEAgLTUwMCw2ICs1MTcsOCBAQCBzdHJ1
Y3QgbW1jX2hvc3Qgew0KPiAgDQo+ICAJLyogSG9zdCBTb2Z0d2FyZSBRdWV1ZSBzdXBwb3J0ICov
DQo+ICAJYm9vbAkJCWhzcV9lbmFibGVkOw0KPiArCXUzMiAgICAgICAgICAgICAgICAgICAgIGVy
cl9zdGF0c1tNTUNfRVJSX01BWF07DQoNCklmIHlvdSBtYWtlIGl0IHU2NCB0aGVuIHdlIGRvbid0
IGhhdmUgdG8gdGhpbmsgYWJvdXQgdGhlIHZhbHVlIG92ZXJmbG93aW5nLg0KDQo+Pj4gU3VyZQ0K
DQo+ICsJYm9vbAkJCWVycl9zdGF0ZTsNCj4gIA0KPiAgCXVuc2lnbmVkIGxvbmcJCXByaXZhdGVb
XSBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+ICB9Ow0KPiBAQCAtNjM1LDYgKzY1NCwyNCBAQCBz
dGF0aWMgaW5saW5lIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9uIG1tY19nZXRfZG1hX2RpcihzdHJ1
Y3QgbW1jX2RhdGEgKmRhdGEpDQo+ICAJcmV0dXJuIGRhdGEtPmZsYWdzICYgTU1DX0RBVEFfV1JJ
VEUgPyBETUFfVE9fREVWSUNFIDogDQo+IERNQV9GUk9NX0RFVklDRTsgIH0NCj4gIA0KPiArc3Rh
dGljIGlubGluZSB2b2lkIG1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19lbmFibGUoc3RydWN0IG1tY19o
b3N0ICptbWMpIA0KPiArew0KPiArCW1tYy0+ZXJyX3N0YXRlID0gdHJ1ZTsNCj4gK30NCj4gKw0K
PiArc3RhdGljIGlubGluZSB2b2lkIG1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoc3RydWN0IG1t
Y19ob3N0ICptbWMsDQo+ICsJCWVudW0gbW1jX2Vycl9zdGF0IHN0YXQpIHsNCj4gKw0KPiArCS8q
DQo+ICsJICogSWdub3JlIHRoZSBjb21tYW5kIHRpbWVvdXQgZXJyb3JzIG9ic2VydmVkIGR1cmlu
Zw0KPiArCSAqIHRoZSBjYXJkIGluaXQgYXMgdGhvc2UgYXJlIGV4Y2VwdGVkLg0KPiArCSAqLw0K
PiArCWlmICghbW1jLT5lcnJfc3RhdGUpDQo+ICsJCW1tYy0+ZXJyX3N0YXRzW01NQ19FUlJfQ01E
X1RJTUVPVVRdID0gMDsNCg0KVGhpcyB3b3VsZCBiZSBiZXR0ZXIgaGFuZGxlZCBpbiB0aGUgY2Fy
ZCBpbml0IGNvZGUgc29tZXdoZXJlLCBub3QgaGVyZS4NCg0KPj4+PiBTdXJlLg0KDQo+ICsNCj4g
KwltbWMtPmVycl9zdGF0c1tzdGF0XSArPSAxOw0KPiArfQ0KPiArDQo+ICBpbnQgbW1jX3NlbmRf
dHVuaW5nKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwgdTMyIG9wY29kZSwgaW50IA0KPiAqY21kX2Vy
cm9yKTsgIGludCBtbWNfc2VuZF9hYm9ydF90dW5pbmcoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1
MzIgDQo+IG9wY29kZSk7ICBpbnQgbW1jX2dldF9leHRfY3NkKHN0cnVjdCBtbWNfY2FyZCAqY2Fy
ZCwgdTggDQo+ICoqbmV3X2V4dF9jc2QpOw0KPiANCg0K
