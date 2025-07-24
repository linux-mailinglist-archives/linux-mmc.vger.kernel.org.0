Return-Path: <linux-mmc+bounces-7579-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C21EB109C1
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Jul 2025 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82856AC6645
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Jul 2025 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A252BE657;
	Thu, 24 Jul 2025 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fe+jvu3V"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902C2BE643
	for <linux-mmc@vger.kernel.org>; Thu, 24 Jul 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358307; cv=none; b=qLhHBRbS/kPzI/FAlGdVMbDd9OlEy2OHgZylseH/OsN4zEKHHAt9qiG4yxqCotS3F4U6WRAhlR6YbM6rSxETGr7NiKH/eDDbjVscPkcHTMeWh9CGMFQ7sC9g5EWKSgiMWSVsZfVlW27lilM6ybqVh6OvOhhyjP99uMod4KHC0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358307; c=relaxed/simple;
	bh=LcF+au34T4Y4uoe+PJqyTSxZzQVvy7bMrGLNCMr5qRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=talXV04JvmmnwSbSFT1IWUgpXldsAzZuCIhsysf3YR4EdWpRQrTyrUm96kW97sHAUr6AMH9s0FhZz8j+gv1C6theyJGl1EgDU77/7n/gWwZBRu9AF1C1FgzezxNiMjeqarvTbt7SWH63Ftl82HoLDC77/M8/7IJbwOzE4ybLGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fe+jvu3V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9hsRR028534
	for <linux-mmc@vger.kernel.org>; Thu, 24 Jul 2025 11:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gtE+xlUh+PW7f4cFnhCSMOHE
	EmQN3efVJt3XSMrZRmU=; b=Fe+jvu3VqvRd7J7SqbeutFSAdml9qjHB50Mc3pJN
	ORfudJcfCVs2ru4o66MyfPW4apR8LiZrg3KRYm2dhsdbRvyuuh9w6/EZLxai7e4o
	qyNq93YhiffTmKfryUgeDk1+QDkf95nIhqNRzY0LDQKUavY8r6QFqUYBLXJ0wjVK
	fQyrjWeKOSgDwIQw9n4C/M1XOTF5QwVJySprvSDqckw7Kp/ksq67CpQWpP42ycr5
	X/ngMgfx43ZIeTtZcXEFd7mmi00TpMmTjHY3J5MAMMg5cHL0ePc0oxNgNjfATWW9
	tgJ+RG3UilQJR5weIZeC5m5I1zUNGz9W9D9XNE77QnjeRQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1fx6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 24 Jul 2025 11:58:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e33f7a58f6so150487285a.3
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jul 2025 04:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358304; x=1753963104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtE+xlUh+PW7f4cFnhCSMOHEEmQN3efVJt3XSMrZRmU=;
        b=JsguCVA84v+s/qNQp5OHkW9yxt8c0WpEVyp0RNJY5AOKLd8TkC3dKLfo2In4VFYxpQ
         yn4qHx80frg/rEOg0wIdgIyEeEBZKEEOgKFBrrWycyr0F3+klHmslIFIihg2jTq9Uwl7
         tSFxQTU2nBLCx2DhVOr8HTeAr3EmKscOSIhZIY7ZvdgO3xMOhGvIBh3L+p1spk+XYETX
         yiPdURtkJ7FWyfK+LOTmG24POTvNAxJRj/kOwVtGK9sZ9H5mDT4Gzs417uk1DeVGn+ys
         aCnQAntbuNyGBRZF0+s+ceB6rZ5GUq9D9zltejCbDGPSCSNR83qz7AXntMCK5yjEPulE
         Lyeg==
X-Forwarded-Encrypted: i=1; AJvYcCW1LegrXR+DX2ZunXISly6WTwapWIQ+Jo8TaiXuTYPnCjyHqxhi91MdXG6TOGVSDsi6XmO92ch+Nf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+NrASmvn9pn8txmHBUn2gMyfTdA913JvVI9omuFfsaQ1fwo2
	BP4dwePYiVwrHfT4SKj3o0xdyiBV8qowTJjWPKmAD3Blz+TUqO5QbA6MKl+c8CXxKaLhbmHp+BJ
	15bojprI1k+I+bD+ingnboPbW9eZXkVJRJvj114FOStsvxrs9ybLOlDbFT9AePZg=
X-Gm-Gg: ASbGncvEsjmyuz6cEyPKuLJ0LTvB3UvaNAHaO08kPhFg4U0IZwKNt+DJ3PjHp7sbzuU
	evWLAfK+uR8ney60mvWEj7cN4sK/G99z984FiNSWmlaDYWG4Iv6px9pt99hjGIKuU+knpd1DCsj
	ukyFnCwP1jWV5M+3aoi4u5Yq5h9eKgvAqTzNmky01X4b1aC3N1xEuKM9/imVk6eCsHd7FJ3+Bm5
	OIbMaXkFqtFC/wE0xtaxzPAkiOc85hi7xMo68ACI8jdhouPA93y0HqXuS+kl4dsfKcp1MHR47HV
	y7ZT4AFqZXY7VZ5fUg3LrR0UYrxGK8V6lESYZ+gieHv+KYbXpYkgmKR0vLXnwUszHBkIDvQ+M//
	qQmlCk3HQmzMRxK2f4V+EihNW50IRehnVaGd+onxOKWRt8P92JNTX
X-Received: by 2002:a05:620a:a914:b0:7e6:2782:34cb with SMTP id af79cd13be357-7e62a1803d6mr873603785a.30.1753358303742;
        Thu, 24 Jul 2025 04:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQqSXoopFmxXR9ck1aAjPPx2gGTxSyeulvBYt/V6+sgf9uKacatczHtr7h6WkHRPWjTu8avw==
X-Received: by 2002:a05:620a:a914:b0:7e6:2782:34cb with SMTP id af79cd13be357-7e62a1803d6mr873600085a.30.1753358303278;
        Thu, 24 Jul 2025 04:58:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331e074d9b9sm2667531fa.3.2025.07.24.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:58:22 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:58:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
Message-ID: <z3lucllumwco5xcvphnzwaqjvdhmbraofhww4i427exqfhxrot@rsrvalmulhup>
References: <10c90fee-ce7f-4034-9028-4252f19cb67f@quicinc.com>
 <CAA8EJpoLLDXFQk-ViuaioKrECzMV0aUrcOj4v+Ufs4oHY53mrw@mail.gmail.com>
 <064d3eed-c2ea-4b41-85b2-d2a5a922f8c7@quicinc.com>
 <ehgjdszjr34xppmkrkicb4pnq326nor26tqu2ekop6ew2j3y3h@pm45aiipzuc5>
 <48c73675-a73f-46f1-81a9-f701a2cf00a5@quicinc.com>
 <c1ebdaf1-92bb-4f73-bca9-35246d7c10e1@oss.qualcomm.com>
 <ca83b841-aea0-4233-93fe-02a7b5985af4@quicinc.com>
 <1a0a5178-fcf0-49b6-8e4c-1393c0f4f229@oss.qualcomm.com>
 <CAPDyKFo9gUOB0VhQn=zD0RDM0=8wO08=VmA6XkHv0EN7M89bjg@mail.gmail.com>
 <9d4b5382-1536-471b-8f4a-a0ccbbcf1489@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4b5382-1536-471b-8f4a-a0ccbbcf1489@quicinc.com>
X-Proofpoint-GUID: 8kgp7OlrcqL6SU0w0cNyzGaxw29RpfTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MCBTYWx0ZWRfX20MI2YpLR6Q1
 iB0WJmgaAGQkIvg0f0KamLb6KwZV25T0jQJt1smTUHaIrWEZU8iOnvlQ5hZ+TSK3HXml/fbiHcM
 T658LoeyRK7vqSIJwthc59jKi3+4zynQT48H8Hv3RMByqyWDf1GMlo7gROjTxNCroZTACvs3naz
 jsDgzsCca+YsPQrmAMuip3dnlh2DOwC0+Wy9La/YGU8Ro5+TrJ+/cXuvOVtte7N8Oh6ZksZE4oB
 hZlfCJUYcfsRYi4UjWjjWdtK9khqroWFk4V3tVJX4EFDS0FxRWaQxGbwz+7Xf28/lTlJAFaODV8
 u/3ctzsrshfR0nVZ/pgVkYq8DtL7KQ0JAk8iE5mLwDSIGfdthsNTsZHyKN6PIv7uZUJeEn2Mzn2
 N08r97NB+0pHqSevMCHdFJPBkw1tOfC8gLgVnEoHYGcrOjH8J8o9XhAXzw8T4FWjOyMbp1fh
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68821fe0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=fzXwuMWa66Y-jPmIjq8A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8kgp7OlrcqL6SU0w0cNyzGaxw29RpfTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240090

On Thu, Jul 24, 2025 at 05:12:56PM +0530, Sarthak Garg wrote:
> 
> 
> On 5/27/2025 8:50 PM, Ulf Hansson wrote:
> > On Wed, 21 May 2025 at 17:41, Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > 
> > > On 21/05/2025 18:36, Sarthak Garg wrote:
> > > > 
> > > > 
> > > > On 5/21/2025 8:19 PM, Dmitry Baryshkov wrote:
> > > > > On 21/05/2025 17:35, Sarthak Garg wrote:
> > > > > > 
> > > > > > 
> > > > > > On 5/21/2025 6:25 PM, Dmitry Baryshkov wrote:
> > > > > > > On Wed, May 21, 2025 at 12:46:49PM +0530, Sarthak Garg wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 11/15/2024 6:53 PM, Dmitry Baryshkov wrote:
> > > > > > > > > On Fri, 15 Nov 2024 at 12:23, Sarthak Garg
> > > > > > > > > <quic_sartgarg@quicinc.com> wrote:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > On 11/4/2024 4:19 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
> > > > > > > > > > > > Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> > > > > > > > > > > > This enables runtime PM for eMMC/SD card.
> > > > > > > > > > > 
> > > > > > > > > > > Could you please mention, which platforms were tested with this
> > > > > > > > > > > patch?
> > > > > > > > > > > Note, upstream kernel supports a lot of platforms, including
> > > > > > > > > > > MSM8974, I
> > > > > > > > > > > think the oldest one, which uses SDHCI.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > This was tested with qdu1000 platform.
> > > > > > > > > 
> > > > > > > > > Are you sure that it won't break other platforms?
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Thanks for your valuable comment.
> > > > > > > > I am not sure about the older platforms so to avoid issues on older
> > > > > > > > platforms we can enable this for all SDCC version 5.0 targets ?
> > > > > > > 
> > > > > > > No, there are still a lot of platforms. Either explain why this is
> > > > > > > required for all v5 platforms (and won't break those) or find some
> > > > > > > other
> > > > > > > way, e.g. limit the change to QDU1000, explaining why it is _not_
> > > > > > > applicable to other platforms.
> > > > > > > 
> > > > > > 
> > > > > > Thanks for your comment.
> > > > > 
> > > > > No need to.
> > > > >   >> I agree with your concern but for me also its not possible to test on
> > > > > > all the platforms.
> > > > > 
> > > > > Sure.
> > > > > > > Lets say if I want to enable this caps for QDU1000 for which it has
> > > > > > been tested and on any other upcoming target after testing, then how
> > > > > > can I proceed to enable?
> > > > > 
> > > > > Let's start from the beginning: why do you want to enable it on QDU1000?
> > > > > 
> > > > 
> > > > QDU1000 is one latest available target where we have enabled this and
> > > > tested. This has been enabled to save power.
> > > 
> > > Isn't it a powered device? How much power is the save? Is it worth it?
> > 
> > Just wanted to share my view around this, in a slightly more generic
> > way. My answer to the above, would be, yes, for any battery driven
> > platform, it should be worth it.
> > 
> > Unfortunately, I don't have any fresh numbers to share for eMMC/SD,
> > but just searching for some vendor specific information about their
> > eMMC/SD cards, should tell us I think. In fact, this problem isn't
> > even limited to eMMC/SD, but rather applies to most flash based
> > storage (UFS/NVMe etc) that are used on these types of platforms.
> > 
> > How much there is to gain, obviously depends on the internal behaviour
> > of the storage device. Of course, the number of cards being attached
> > is important too.
> > 
> > That said, enabling this feature (MMC_CAP_AGGRESSIVE_PM) needs to be
> > done by taking into account that being *too* aggressive (too
> > frequently) with turning off the power to the card, may cause a
> > potential wear-out/brake of the card if we end up preventing it from
> > doing internal house-keeping for too long.
> > 
> > The current default autosuspend timeout
> > (pm_runtime_set_autosuspend_delay()) is set to 3s in mmc_blk_probe().
> > That seems way too aggressive in my opinion, so perhaps increasing
> > that value to ~180s could allow us to enable this, even if 180s is
> > just a guesstimate from my side.
> > 
> > Also note that, during system wide suspend we always turn off the
> > power to the card - and we really don't know if that is too frequent
> > too. It depends on how the platform is used, compare a laptop with a
> > smartphone, the frequency greatly differs.
> > 
> > Kind regards
> > Uffe
> 
> 
> Hi ulf,
> 
> We already have AGGRESSIVE_PM enabled for all our internal targets and they
> are in production for quite long time (5-6 years) and haven't seen and

Upstream kernels support targets starting from APQ8060, so they are much
older than 5-6 years. For example, I'd like to point out several SDHCI
v4 targets (MSM8974 - MSM8998).

> performance degradations due to garbage collection. Also wear tears are not
> observed as per my current observations so far.
> 
> Like you rightly mentioned we may have battery powered devices where this
> caps will be useful and on the other hand we have always powered devices
> where this caps may not be needed, so can we make device tree changes and
> enable this PM property per board selectively?
> 
> Also I see there are four below vendor files who have already enabled this
> caps in their vendor file.
> 
> sdhci-pci-core.c sdhci-omap.c sdhci-acpi.c rtsx_pci_sdmmc.c
> 
> Let me know how can we proceed.
> 
> Regards,
> Sarthak
> 
> 
> 
> 
> 

-- 
With best wishes
Dmitry

