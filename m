Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9433D360602
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Apr 2021 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhDOJkE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 15 Apr 2021 05:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhDOJkD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Apr 2021 05:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6543C60FD8;
        Thu, 15 Apr 2021 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618479580;
        bh=fKRs3+t1uoeek/kZ5AB7b1RPFvkaRDIonjMnl74NQpY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XaoVXqSM1ly6MBbtzA2ot+K7OEvWVAXxXArxhFhqyOOodCcEaXKo6kT4B2jKXe/HY
         H1YjGlbWQikF/CLNXs0/X/Gv1RRWMosUa0b/HVT55oeuG/EXBcZmZxwLV8x4f7QYv1
         qDPd0zyhgzNcox/JiqOUY7lE05fHDqTWclia3iKFlFz/yTa7WyqVNKSq7qg1tT/4Ev
         rUxFr+eZSjxZu76Ha/Z7ejcieXe/NxQroL9nJr/ctYoEtzT3QTZaYyTpKL0DZU+gXq
         51ulykoDrI3NoRku9Wesivse3p77dh7TFlg609eqLez5gkYCBo3icAAl8+4cdWujST
         T6fYofFB9ZZ7g==
Subject: Re: [PATCH v2 1/3] mmc: sdhci-s3c: simplify getting of_device_id
 match data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <aae59b41-02da-cd93-3dea-2fe7161fcd57@kernel.org>
Date:   Thu, 15 Apr 2021 11:39:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 15.04.2021 10:44, Krzysztof Kozlowski wrote:
> Use of_device_get_match_data() to make the code slightly smaller and to
> remove the of_device_id table forward declaration.
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
