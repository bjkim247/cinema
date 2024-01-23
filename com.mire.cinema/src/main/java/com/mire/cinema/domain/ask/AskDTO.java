package com.mire.cinema.domain.ask;

import java.time.LocalDate;

import com.mire.cinema.domain.notice.NoticeDTO;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

public class AskDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AskResponseDTO {
		private boolean result;
		private String message;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AskWriteDTO {
		private Long askNo;
		@NotBlank(message = "제목을 입력하세요")
		private String askTitle;
		@NotBlank(message = "문의사항을 입력하세요")
		private String askContent;
		private LocalDate askDate;
		private String imageUuid;
		private String memberId;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AskUpdate {
		private Long askNo;
		@NotBlank(message = "제목을 입력하세요")
		private String askTitle;
		@NotBlank(message = "문의사항을 입력하세요")
		private String askContent;
		private String imageUuid;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Delete {
		private Long askNo;
	}

	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Info {
		private Long askNo;
		private String askTitle;
		private String askContent;
		private LocalDate askDate;
	}
	
	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Search {
		private String askTitle;
		private int startNum;
		private int endNum;
	}
}
