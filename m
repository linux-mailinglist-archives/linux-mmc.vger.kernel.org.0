Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72699DA07
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 01:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfHZXg7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 19:36:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46221 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbfHZXg7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Aug 2019 19:36:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 33D8E21D25;
        Mon, 26 Aug 2019 19:36:58 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 26 Aug 2019 19:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=wixTDJAQbjY/Vhzqeg4T1GumEprOkBk
        N/oC2LEVkCv4=; b=PAbrqX9B8koWzYVJHtqz0pMLPyeyPx4LDW6R86bfbm2tDgI
        8Ytorq10xVp3FU9/kCCeD4uHlcxHO68LG7bWdSuEDzBAWKNQVAsBVoYqC3qOxNVn
        1kDNkrl+aINL/oeLFipUO590mawo5SXiRKS7kXEu8+tUGkV0MdB1WkDlgILjS/WT
        XeyOffwLJ0YyWpeMdtFVzTQJaxgABEIMtzISgxTrr0PhyV3V2kHK+GwKaUflyXeF
        g6u8OWQCn32uEICm44xDtJgR7MgOXA1zQIxcOMoO2EQNHcuLsKnb5LV3fnzZ98q7
        Vy9eVTQgCpeZFeYko3Pf54ZG6b2hMKguh+6QchQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wixTDJ
        AQbjY/Vhzqeg4T1GumEprOkBkN/oC2LEVkCv4=; b=HDDSyOKngXZbkHXmFgvbQe
        FD8fS4uguq8G+lP1l18m+FzQ92yq/qe2r01oAZJrl7vAePmniV2yN9JgdX/gIeD0
        aY38FutFDXejMBUl/z3HRs5JrrrJVLx5L2eH5m6aoKY3vp/R24fzNp+8WDM1frpM
        3ogrIvSoq9GrPo+6yZEuUdg8i7NzNunTNJNcjYN9hLd38RCxvBivsNyW4XAz8/Zu
        z93qALwF1K+LSTuP+/KEXtiiuTGQqCPk5GcVplcfSceCIy/o0EptNT/GcPZvZ1kN
        kXn/Kr8hnuvUrBly1sgg1qij4cSdqyg2I/JwaYWffCV/kWEQ+wURmcejSr6gQEbA
        ==
X-ME-Sender: <xms:GG1kXQ5D7mvyUHzjBokdQs4dTqgCuZjWam5BGykLec7vvvcx5B080w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehhedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:GG1kXUVNImv6Gofm_nM9OW946oVf_CuldymEbwxsvyfzsV6mJGOxEQ>
    <xmx:GG1kXdLF142R19ES50NeD_RzadR7Wg5AhhX12x75rQdBEm4W7PGp5g>
    <xmx:GG1kXUTXGDHv1NFe9Cu14mPcsMpa5wb8gnRIO0fMO-jc2CajPlMKig>
    <xmx:Gm1kXedKe0BHGFlFqZnx-d49jziKU13sk_W_B72cbh1vt4v0U_5-Ug>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AF0E0E00A3; Mon, 26 Aug 2019 19:36:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-916-g49fca03-fmstable-20190821v7
Mime-Version: 1.0
Message-Id: <629128e7-cc91-412f-8946-668fac2eb3b9@www.fastmail.com>
In-Reply-To: <20190826130343.GA23584@kadam>
References: <20190826120013.183435-1-weiyongjun1@huawei.com>
 <20190826130343.GA23584@kadam>
Date:   Tue, 27 Aug 2019 09:07:17 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Wei Yongjun" <weiyongjun1@huawei.com>
Cc:     "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_-next]_mmc:_aspeed:_Fix_return_value_check_in_aspee?=
 =?UTF-8?Q?d=5Fsdc=5Fprobe()?=
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Mon, 26 Aug 2019, at 22:34, Dan Carpenter wrote:
> > Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
>                         ^^^^
> When we're adding new files, could we use the prefix for the new driver
> instead of just the subsystem?  "mmc: aspeed: Add new driver"?
> Otherwise it's tricky to know what people want for the driver.

I don't have any issue with the request, but I don't understand this last
bit. What do you mean by "it's tricky to know what people want for the
driver"?

Andrew
