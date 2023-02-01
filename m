Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C440968280C
	for <lists+linux-mmc@lfdr.de>; Tue, 31 Jan 2023 10:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAaJF0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 31 Jan 2023 04:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjAaJEx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 04:04:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AC82D50;
        Tue, 31 Jan 2023 01:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=zzLsGiLpg3sDlIcnH/4TM1gEfT
        PMYpVh8i/2J+j/LHb2QYDgTjfdHNP/fs2mMHiuKTDjnToOQ+uIBEIEjkWT9j66QII2E6xvAu796es
        kKAUZdM4SSKR6EpcxHRLD7L01+BpwFsgd2BN5ud/lqK62XlZanc7W56N0gfjrjdCi05O1ileoXYwz
        lXz9OSn8NSmAK8Sh3NvWrFTOpoCWqtFrwW2YhdqpnNzpIDaRv7DKhbfic6c2xSaKYFDO+MSyPTEdo
        XdKE4PHUBC9iToIeFdY59TiFOdxM3irWvzDPTz5guk+XqaqznxfgKMLxTeDHXIZSKmdc6FQj8HzjG
        xEtREtPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMmW5-006t3v-Uw; Tue, 31 Jan 2023 09:01:25 +0000
Date:   Tue, 31 Jan 2023 01:01:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] memstick: core: Imply IOSCHED_BFQ
Message-ID: <Y9jY5dJFcqIJbbmE@infradead.org>
References: <20230131085220.1038241-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131085220.1038241-1-linus.walleij@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

