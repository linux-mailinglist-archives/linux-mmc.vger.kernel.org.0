Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C515D103416
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2019 07:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfKTGFf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Nov 2019 01:05:35 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46209 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfKTGFf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Nov 2019 01:05:35 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 33C6266D1;
        Wed, 20 Nov 2019 01:05:34 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 20 Nov 2019 01:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=MqACBpEH9i8p185f/jCjhS3Buz1frYL
        b77NTyx979Vk=; b=i7XKy7y1PAPvEgYOMCazKDu7BXD8GlpoYO0b/DBDIBevIRN
        oSsmkXzqiXQhG2Jq+Qd5XDA42EyYTg48eht/Xln+pFFphAE4Wr5BupTMdKWlM3Fw
        jn2JmooRWq+DeV9QmpImEqvvRg/G9PATHSu8qX6Id4TeTDXir6MfOqFb5mm03mbX
        XnyTSMzM4Wwzcb1sKe7CAgaRzKPRWUCpYZTRQTTvIt4EYuTxBHfXgO0RA+JrOkZZ
        zO1+/ONdWl3BYsmF5yWiE3nJdQFQwlQKPBIxT2cz9AtL+FCRZZBKwCREIPzoP8V4
        myUat4Xt/IJGWXwFQ0iYbWY6hKjn4TuIMPP8ILw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MqACBp
        EH9i8p185f/jCjhS3Buz1frYLb77NTyx979Vk=; b=LJ4yst4Apz2MLuo0lKehfh
        zMqxHdvAShQNWZwqQaXHzMmELTPswvADN1bS/OhbNjs6PJv3KkqqVHb85IVuIOqI
        KerhvkyjTNmn688uJvc5szdzWrKmoG06NYfXFhTPE3yPvp/mJlA2aUCdro0fT1C8
        LFnFIIIo9rvQPLtwVUHRxgvKhq/411RQz5zEQzYDgrxnaBTlliA227Vf1O4Z64MX
        nunTveBc+fvoGSEbpprjVbKiMrLV6eAGKXJqT4Zh6iqYONYU+Byof6x0VjqjsSws
        YIg9bUJeUjmDz3lC281U3WRxW+PDAEMTrFScfZ+NHCJdXLmJtsK0OyAnsgZ9rpyw
        ==
X-ME-Sender: <xms:q9fUXalOHeplB8yX1vzlWHBcSscnF4HNXZBSR9sI3r-PvqyKms2BJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudegledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:q9fUXVQwd6XqjXTUXw50wQGrHC2F8Cs31GSA51fL3LNn58J3g-mz4w>
    <xmx:q9fUXVYlNjqiogexue1MOxuvWRhS75Wbdx0YSdrb4eH9sDbiYxYrMg>
    <xmx:q9fUXR8XH-IwBjQObAQ_n6vciRRjHt9VPTLSKP0mMGCrZkUTZRPGJg>
    <xmx:rtfUXf--SERIAc9OW-KEysE8HrVyG9VEO-RmAfdYmXiXxkt6cTDpbQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A0D9E00AA; Wed, 20 Nov 2019 01:05:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <b525ea84-aaa0-45b3-95fd-a1b3518511b3@www.fastmail.com>
In-Reply-To: <20191118104646.3838-4-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-4-i.mikhaylov@yadro.com>
Date:   Wed, 20 Nov 2019 16:36:55 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ivan Mikhaylov" <i.mikhaylov@yadro.com>
Cc:     "Joel Stanley" <joel@jms.id.au>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>, openbmc@lists.ozlabs.org
Subject: =?UTF-8?Q?Re:_[PATCH_v3_3/3]_mmc:_sdhci-of-aspeed:_add_inversion_signal_?=
 =?UTF-8?Q?presence?=
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 Nov 2019, at 21:16, Ivan Mikhaylov wrote:
> Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
> bit in case of inverted card detection signal.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
